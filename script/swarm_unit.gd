extends RigidBody2D

var attractor: Node2D = null

@export var impulse_strength = 12

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if !is_instance_valid(attractor):
        print_debug("no valid attractor")
        return
    var vec_to_attractor = attractor.position - position
    apply_central_force(delta * vec_to_attractor * impulse_strength)


func _on_pusher_area_area_entered(area):
    var other_pos = area.get_parent().position
    apply_central_impulse((position - other_pos) * 1.3)
