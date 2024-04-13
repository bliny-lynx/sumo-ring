extends RigidBody2D

enum {STAGED, MOVING, FIGHTING}

var state: = STAGED # essentially paused, the characters spawn first and then run at each other
@export var facing_right = true
var direction = Vector2.RIGHT
@onready var impulse_cd = $ImpulseCooldown

func _ready():
    if not facing_right:
        direction = Vector2.LEFT
    else:
        $Sprite2D.flip_h = true

func unstage():
    state = MOVING



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if state == STAGED:
        return
    if state == MOVING:
        apply_central_impulse(direction)
    if state == FIGHTING:
        print("not implemented")
        # do something else



func _on_impulse_cooldown_timeout():
    apply_central_impulse(direction)
