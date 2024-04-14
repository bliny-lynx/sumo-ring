extends Node2D

var type = Gamestate.Item.SAKE

# Called when the node enters the scene tree for the first time.
func _ready():
    $Sprite2D.visible = false
    if type == Gamestate.Item.FAIL_SUMMON:
        $AnimatedSprite2D.play("fail")
    else:
        $Sprite2D.texture = load(Gamestate.items[type]["texture"])
        $AnimatedSprite2D.play("default")


func _on_animated_sprite_2d_animation_finished():
    $AnimatedSprite2D.visible = false
    $Sprite2D.visible = true
    if type == Gamestate.Item.FAIL_SUMMON:
        queue_free()
