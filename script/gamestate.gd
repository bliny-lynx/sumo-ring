extends Node

enum Item {SUSI, SAKE, ONIGIRI}
var equipped_items = []
var mana = 10.0
var max_mana = 90.0
var items = {
    Item.SUSI: {
        "description": "+weight\n+strength\n30 mana",
        "cost": 30,
        "texture": "res://sprite/Sushirulla.png"
    },
    Item.SAKE: {
        "description": "+anger\n+inebriation\n40 mana",
        "cost": 40,
        "texture": "res://sprite/Sake.png"
    },
    Item.ONIGIRI: {
        "description": "++weight\n20 mana",
        "cost": 20,
        "texture": "res://sprite/Onigiri.png"
    }
}
var effects = [
    "+weight\n+strength\n30 mana",
    "+strength\n+anger\n+danger\n40 mana",
    "++weight\n20 mana"
]
var mana_costs = [30, 40, 20]
# Called when the node enters the scene tree for the first time.
func _ready():
    mana = max_mana

func add_item(item):
    equipped_items.append(item)

func spend_mana(amount):
    mana -= amount

func get_mana_per_cent():
    return (mana / max_mana) * 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass
