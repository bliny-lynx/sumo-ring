extends Node2D

var unit_scene = preload("res://scene/swarm_unit.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func spawn():
    var s = unit_scene.instantiate()
    s.position = position + Vector2(randf_range(-50.0, 40.0), randf_range(-50.0, 60.0))
    s.attractor = self
    get_parent().add_child(s)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var m_po = get_viewport().get_mouse_position()
    position = lerp(position, m_po, delta * 12)


func _input(event):
    if event is InputEventKey and event.pressed:
        spawn()
