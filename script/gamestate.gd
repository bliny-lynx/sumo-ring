extends Node

enum Item {SUSI, SAKE, ONIGIRI, FAIL_SUMMON = -1}
var equipped_items = []
var mana = 10.0
var max_mana = 22.0
var items = {
    Item.SUSI: {
        "description": "+weight\n+strength\n4 mana",
        "cost": 4,
        "growth": 0.3,
        "alcohol": null,
        "strength": 0.5,
        "texture": "res://sprite/Sushirulla.png"
    },
    Item.SAKE: {
        "description": "+anger\n+inebriation\n6 mana",
        "cost": 6,
        "growth": null,
        "alcohol": 1,
        "strength": 0.3,
        "texture": "res://sprite/Sake.png"
    },
    Item.ONIGIRI: {
        "description": "++weight\n3 mana",
        "cost": 3,
        "growth": 0.7,
        "strength": 0.1,
        "alcohol": null,
        "texture": "res://sprite/Onigiri.png"
    }
}

func status_effects():
    var weight_effect = 0.0
    var alcohol = 0
    for item in equipped_items:
        if item["growth"]: weight_effect += item["growth"]
        if item["alcohol"]: alcohol += item["alcohol"]
    return {
        "weight": weight_effect,
        "inebriation": alcohol
    }

func _ready():
    mana = max_mana

func equip(item):
    equipped_items.append(item)

func spend_mana(amount):
    mana -= amount

func get_mana_per_cent():
    return (mana / max_mana) * 100


func _process(_delta):
    pass
