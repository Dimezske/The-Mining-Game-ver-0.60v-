extends Node

var enemy_data: Dictionary

func _ready():
	enemy_data = LoadData("res://Assets/Enemies/DATA/EnemyData.json")

func LoadData(file_path):
	var json_data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()
	return json_data.result
