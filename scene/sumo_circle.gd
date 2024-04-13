extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
    $Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass


func _on_timer_timeout():
    print_debug("fighting")
    get_tree().call_group("wrestlers", "unstage")


func _on_lose_area_body_entered(body):
    print("you lose!")


func _on_victory_area_body_entered(body):
    print("you win!")
