extends Node2D

var item_type
var i_quantity

func _ready():
	var rand_val = randi() % 3
	if rand_val == 0:
		item_type = "Diamond Sword"
	elif rand_val == 1:
		item_type = "stick"
	else:
		item_type = "Spear"
	
	$TextureRect.texture = load("res://item_icons/" + item_type + ".png")
	var stack_size = int(JsonData.item_data[item_type]["StackSize"])
	i_quantity = randi() % stack_size + 1
	
	if stack_size == 1:
		$Label.visible = false
	else: 
		$Label.text = str(i_quantity)

func add_i_quantity(amount_to_add):
	i_quantity += amount_to_add
	$Label.text = str(i_quantity)
	
func lower_i_quantity(amount_to_lower):
	i_quantity -= amount_to_lower
	$Label.text = str(i_quantity)
	
