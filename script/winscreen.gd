extends Node2D

func _on_continuebutton_pressed():
    Audio.click_sfx()
    Gamestate.reset()
    get_tree().change_scene_to_file("res://scene/lockerroom.tscn")

func _on_retirebutton_pressed():
    Audio.click_sfx()
    get_tree().quit()
