extends CanvasLayer



func _input(event):
	if event.is_action_pressed("Inventory"):
		$Inventory.visible = !$Inventory.visible

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


