extends Node2D

var textures = {
    Gamestate.Item.SAKE: "res://sprite/Sake.png",
    Gamestate.Item.ONIGIRI: "res://sprite/Onigiri.png",
    Gamestate.Item.SUSI: "res://sprite/Sushirulla.png"
}
var type = Gamestate.Item.SAKE

# Called when the node enters the scene tree for the first time.
func _ready():
    $Sprite2D.texture = load(textures[type])
    $Sprite2D.visible = false
    $AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_animated_sprite_2d_animation_finished():
    $AnimatedSprite2D.visible = false
    $Sprite2D.visible = true
