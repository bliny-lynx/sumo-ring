extends Node2D

@onready var effect_info = $Effectinfo

var consumable = load("res://scene/consumable.tscn")
var curr_idx = 0
@onready var item_slots = [$Marker2D, $Marker2D2, $Marker2D3, $Marker2D4, $Marker2D5]


# Called when the node enters the scene tree for the first time.
func _ready():
    $TextureProgressBar.value = Gamestate.get_mana_per_cent()
    $FatMan.get_node("Sprite2D").play("default")
    $FatMan.get_node("Sprite2D").stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    $TextureProgressBar.value = Gamestate.get_mana_per_cent()


func _on_button_pressed():
   get_tree().change_scene_to_file("res://scene/sumo_circle.tscn")


func _on_item_list_mouse_entered():
    effect_info.visible = true

func can_summon(type):
    return Gamestate.items[type]["cost"] <= Gamestate.mana

func summon(type):
    if curr_idx >= len(item_slots):
        print_debug("full items")
        return
    var item_desc = Gamestate.items[type]
    var new_item = consumable.instantiate()
    Gamestate.spend_mana(item_desc["cost"])
    new_item.type = type
    new_item.position = item_slots[curr_idx].position
    add_child(new_item)
    curr_idx += 1
    Gamestate.equip(item_desc)
    # below is just for effect display
    if curr_idx >= len(item_slots):
        $Summonbutton.disabled = true
    if item_desc["growth"]:
        $FatMan.grow(item_desc["growth"])
    if item_desc["alcohol"]:
        $FatMan.drink()
    elif $FatMan.downed():
        $FatMan.recover()

func fail_summon():
    #TODO(sound): play fail sound
    var new_item = consumable.instantiate()
    new_item.type = Gamestate.Item.FAIL_SUMMON
    new_item.position = item_slots[curr_idx].position
    add_child(new_item)

func _on_item_list_item_clicked(index, _at_position, _mouse_button_index):
    $Summonbutton.disabled = (curr_idx >= len(item_slots))

    effect_info.text = Gamestate.items[index]["description"]

func _on_summonbutton_pressed():
    var type = $ItemList.get_selected_items()[0]
    if !can_summon(type):
        fail_summon()
        return
    summon(type)
