extends Node2D

var spawnee = load("res://scene/fat_man.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func spawn(pos, dir):
    var s = spawnee.instantiate()
    s.position = pos
    s.direction = dir
    add_child(s)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _input(event):
    if event is InputEventMouseButton and event.pressed:
        if event.button_index == MOUSE_BUTTON_LEFT:
            print("clicked at ", event.position)
            spawn(event.position, Vector2.RIGHT)
        if event.button_index == MOUSE_BUTTON_RIGHT:
            print("rclicked at ", event.position)
            spawn(event.position, Vector2.LEFT)
        if event.button_index == MOUSE_BUTTON_MIDDLE:
            get_tree().call_group("wrestlers", "unstage")
