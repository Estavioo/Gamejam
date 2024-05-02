extends Node2D

const SlotClass = preload("res://scripts/Slot.gd")
@onready var inventory_slots = $GridContainer
var holding_item = null

func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.gui_input.connect(slot_gui_input.bind(inv_slot))
		
func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.items:
					slot.PlaceSlot(holding_item)
					holding_item = null
				else:
					if holding_item.item_type != slot.items.item_type:
						var temp_item = slot.items
						slot.SelectSlot()
						temp_item.global_position = event.global_position
						slot.PlaceSlot(holding_item)
						holding_item = temp_item
					else:
						var stack_s = int(JsonData.item_data[slot.items.item_type]["StackSize"])
						var able_add = stack_s - slot.items.i_quantity
						if able_add >= holding_item.i_quantity:
							slot.items.add_i_quantity(holding_item.i_quantity)
							holding_item.queue_free()
							holding_item = null
						else: 
							slot.items.add_i_quantity(able_add)
							holding_item.lower_i_quantity(able_add)
			elif slot.items:
				holding_item = slot.items
				slot.SelectSlot()
				holding_item.global_position = get_global_mouse_position()

func _input(_event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
				


