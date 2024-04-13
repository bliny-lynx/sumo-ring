extends Node

enum Item {SUSI, SAKE, ONIGIRI}
var equipped_items = []
var mana = 100
var max_mana = 250

# Called when the node enters the scene tree for the first time.
func _ready():
    mana = max_mana

func spend_mana(amount):
    mana -= amount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass
