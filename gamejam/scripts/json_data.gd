extends Node

var item_data: Dictionary

func _ready():
	item_data = LoadData("res://JSON/Item_Data.json")

func LoadData(file_path):
	var F_Data = FileAccess.open(file_path, FileAccess.READ)
	var json_D = JSON.new()
	json_D.parse(F_Data.get_as_text())
	F_Data.close()
	return json_D.get_data()
