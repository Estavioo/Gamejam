extends Panel

var Occupied_Slot = preload("res://item_icons/Item_icon_texture.png")
var Empty_Slot = preload("res://item_icons/Item_empty_icon_texture.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var Item_Class = preload("res://Inventory_Scenes/Item.tscn")
var items = null

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = Occupied_Slot
	empty_style.texture = Empty_Slot
	
	if randi() % 2 == 0:
		items = Item_Class.instantiate()
		add_child(items)
	refresh_style()

func refresh_style():
	if items == null:
		set('theme_override_styles/panel', empty_style)
	else: 
		set('theme_override_styles/panel', default_style)

func SelectSlot():
	remove_child(items)
	var Node_inventory = find_parent("Inventory")
	Node_inventory.add_child(items)
	items = null
	refresh_style()

func PlaceSlot(new_items):
	items = new_items
	items.position = Vector2(0,0)
	var Node_inventory = find_parent("Inventory")
	Node_inventory.remove_child(items)
	add_child(items)
	refresh_style()
