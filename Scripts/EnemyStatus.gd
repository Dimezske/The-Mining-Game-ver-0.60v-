extends Node2D

var enemy_name

func _ready():
	var rand_val = randi() % 3
	if rand_val == 0:
		enemy_name = "Black Ant"
	elif rand_val == 1:
		enemy_name = "Black Ant"
	else:
		enemy_name = "Black Ant"
	$Backing/TextureRect.texture = load("res://Assets/Enemies/Icons/" + enemy_name + ".png")
	var stack_size = int(JsonData.enemy_data[enemy_name])

func set_enemy(en):
	enemy_name = en

	$Backing/TextureRect.texture = load("res://Assets/Enemies/Icons/" + enemy_name + ".png")
	
	var stack_size = int(JsonData.enemy_data[enemy_name])
	if stack_size != null:
		$EnemyName.visible = false
		$HealthContainer.visible = false
		$EnergyContainer.visible = false
	else:
		$EnemyName.visible = true
		$HealthContainer.visible = true
		$EnergyContainer.visible = true
