extends Node2D

func _on_continuebutton_pressed():
    Gamestate.reset()
    get_tree().change_scene_to_file("res://scene/lockerroom.tscn")

func _on_retirebutton_pressed():
    get_tree().quit()
    get_tree().change_scene_to_file("res://scene/retire.tscn")
