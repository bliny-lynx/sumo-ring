extends RigidBody2D

enum {STAGED, MOVING, FIGHTING}

var state: = STAGED # essentially paused, the characters spawn first and then run at each other
var direction = Vector2.RIGHT

func _ready():
    pass # Replace with function body.

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

