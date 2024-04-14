extends Node

enum Phase {INTRO, LOCKER, BATTLE}
var phase = Phase.INTRO
enum Item {SUSI, SAKE, ONIGIRI, FAIL_SUMMON = -1}
var equipped_items = []
var mana = 10.0
var max_mana = 22.0
var items = {
    Item.SUSI: {
        "description": "+weight\n+strength\n4 mana",
        "cost": 4,
        "growth": 0.2,
        "alcohol": null,
        "strength": 8,
        "slow": null,
        "texture": "res://sprite/Sushirulla.png"
    },
    Item.SAKE: {
        "description": "+anger\n+inebriation\n6 mana",
        "cost": 6,
        "growth": null,
        "alcohol": 1,
        "strength": 32,
        "slow": null,
        "texture": "res://sprite/Sake.png"
    },
    Item.ONIGIRI: {
        "description": "++weight\n-speed\n3 mana",
        "cost": 3,
        "growth": 0.4,
        "strength": 3,
        "alcohol": null,
        "slow": 0.2,
        "texture": "res://sprite/Onigiri.png"
    }
}

func status_effects():
    if phase < Phase.BATTLE:
        print_debug("not yet battle")
        return null
    var weight_effect = 0.0
    var alcohol = 0
    var strength = 0.0
    var slow = 0.0
    for item in equipped_items:
        if item["growth"]: weight_effect += item["growth"]
        if item["alcohol"]: alcohol += item["alcohol"]
        if item["strength"]: strength += item["strength"]
        if item["slow"]: slow += item["slow"]
    return {
        "weight": weight_effect,
        "inebriation": alcohol,
        "strength": strength,
        "slow": slow
    }

func reset():
    equipped_items = []
    mana = max_mana

func _ready():
    phase = Phase.INTRO
    mana = max_mana

func equip(item):
    equipped_items.append(item)

func spend_mana(amount):
    mana -= amount

func get_mana_per_cent():
    return (mana / max_mana) * 100


