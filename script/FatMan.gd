extends RigidBody2D

enum {STAGED, MOVING}

var state: = STAGED # essentially paused, the characters spawn first and then run at each other
@export var facing_right = true
var direction = Vector2.RIGHT
@onready var impulse_cd = $ImpulseCooldown
@onready var progress_bar = $Line2D
var power = 7
var size = 3.0
@onready var dustspin = $Dustspin

func _ready():
    if not facing_right:
        $Dustspin.flip_h = true
        $Dustspin.position.x = -$Dustspin.position.x
        direction = Vector2.LEFT
        $Sprite2D.flip_h = true
    else:
        $Sprite2D.play("drunk")

func unstage():
    impulse_cd.start()
    state = MOVING

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if state == STAGED:
        return
    progress_bar.points = PackedVector2Array([Vector2(-impulse_cd.time_left * 20, 0), Vector2(impulse_cd.time_left * 20, 0)])

func _on_impulse_cooldown_timeout():
    dustspin.visible = true
    dustspin.play()
    apply_central_impulse(direction * power)
    if facing_right:
        power += randf_range(0, 2)
    power += randf_range(-1, 1)


