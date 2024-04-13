extends Node2D

@onready var effect_info = $Effectinfo

var consumable = load("res://scene/consumable.tscn")
var index = 0
@onready var item_slots = [$Marker2D, $Marker2D2, $Marker2D3]
var mana_costs = [20, 15, 40]

# Called when the node enters the scene tree for the first time.
func _ready():
    $TextureProgressBar.value = Gamestate.mana / Gamestate.max_mana


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    print_debug(Gamestate.mana)
    $TextureProgressBar.value = Gamestate.mana / Gamestate.max_mana
    print_debug($TextureProgressBar.value)


func _on_button_pressed():
   get_tree().change_scene_to_file("res://scene/sumo_circle.tscn")


func _on_item_list_mouse_entered():
    effect_info.visible = true

func summon(type):
    print_debug("index ", index, "slots ", len(item_slots))
    if index >= len(item_slots):
        print_debug("full items")
        return
    var new_item = consumable.instantiate()
    Gamestate.spend_mana(mana_costs[type])
    new_item.type = type
    new_item.position = item_slots[index].position
    add_child(new_item)
    index += 1

var effects = [
    "+weight\n+strength\n20 mana",
    "++weight\n15 mana",
    "+strength\n+anger\n+danger\n40 mana"
]

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
    $Summonbutton.disabled = false
    effect_info.text = effects[index]


func _on_summonbutton_pressed():
    print_debug($ItemList.get_selected_items())
    summon($ItemList.get_selected_items()[0])
