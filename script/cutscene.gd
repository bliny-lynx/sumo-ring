extends Node2D

var story = [
    "Long ago, in a faraway land in the east",
    "Two great clans were enemies",
    "They settled their disputes by sending their CHAMPION",
    "To a match of SUMO WRESTLING.",
    "You are a magical summoner.",
    "You were hired to buff your\nclan's CHAMPION up",
    "By summoning a MAGICAL meal for him",
    "Before the fight"
]
var story_idx = 0
@onready var textboxes = [$Label, $Label2]
var curr_textbox = null

func _ready():
    Audio.play_bg_music()
    advance()

func fade_out():
    var tween = get_tree().create_tween()
    tween.tween_property(curr_textbox, "modulate", Color(1.0, 1.0, 1.0, 0.0), 2.0)
    story_idx += 1
    tween.tween_callback(advance)

func end():
    get_tree().change_scene_to_file("res://scene/lockerroom.tscn")

func advance():
    if story_idx >= len(story):
        end()
        return
    curr_textbox = textboxes[story_idx % 2]
    curr_textbox.text = story[story_idx]
    var tween = get_tree().create_tween()
    tween.tween_property(curr_textbox, "modulate", Color(1.0, 1.0, 1.0, 1.0), 2.0)
    tween.tween_callback(fade_out)

func show_hint():
    $Label3.modulate = Color(1.0, 1.0, 1.0, 1.0)
    $Label3.visible = true
    var tween = create_tween()
    tween.tween_property($Label3, "modulate", Color(1.0, 1.0, 1.0, 0.0), 3.0)

func _input(event):
    if event is InputEventMouseButton:
        show_hint()
    elif event is InputEventKey:
        show_hint()
        if event.keycode == KEY_SPACE:
            end()
