extends Node2D

enum {PREPARE, ONGOING, VICTORY, LOSS}
var state = PREPARE

# Called when the node enters the scene tree for the first time.
func _ready():
    Audio.play_battle_music()
    $SceneTransition.fade_in()
    Gamestate.phase = Gamestate.Phase.BATTLE
    $Timer.start()
    get_tree().call_group("wrestlers", "setup")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass

func _on_timer_timeout():
    if state == PREPARE:
        print_debug("fighting")
        get_tree().call_group("wrestlers", "unstage")
    if state == ONGOING:
        print_debug("Should nvever happen, timer started during battle")
    if state == VICTORY:
        win()
    if state == LOSS:
        lose()

func _on_lose_area_body_entered(_body):
    state = LOSS
    $SceneTransition.fade_out()
    $Timer.start()

func lose():
    Audio.grunt_sfx()
    get_tree().change_scene_to_file("res://scene/losescreen.tscn")

func win():
    Audio.koto_sfx()
    get_tree().change_scene_to_file("res://scene/winscreen.tscn")

func _on_victory_area_body_entered(_body):
    state = VICTORY
    $SceneTransition.fade_out()
    $Timer.start()


