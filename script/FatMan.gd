extends RigidBody2D

enum {STAGED, MOVING}

var state: = STAGED # essentially paused, the characters spawn first and then run at each other
@export var facing_right = true
var direction = Vector2.RIGHT
@onready var impulse_cd = $ImpulseCooldown
@onready var progress_bar = $Line2D
var power = 7
var size = 2.0
var target_size = 2.0
var inebriation = 0
var drunk_anims = ["default", "angry", "drunk", "fall"]
@onready var dustspin = $Dustspin
@onready var growables = [$CollisionShape2D, $Sprite2D]
@onready var tween = null
var next_anim = null

func _ready():
    # TODO scratch all this
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

func downed():
    return inebriation >= len(drunk_anims) - 1

func recover():
    $Sprite2D.play("recover")
    next_anim = "drunk"

func drink():
    inebriation += 1
    if inebriation < len(drunk_anims):
        $Sprite2D.play(drunk_anims[inebriation])
    if downed():
        impulse_cd.stop()

func grow(amount=0.5):
    if is_instance_valid(tween):
        tween.kill()
    tween = get_tree().create_tween()
    target_size += amount
    tween.tween_property(self, "size", target_size, 0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    for g in growables:
        g.scale = Vector2(size, size)
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
