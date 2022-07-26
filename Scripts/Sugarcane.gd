extends KinematicBody2D

var filenames_array = ["res://Assets/Agriculture/Plants/Sugarcane-3.png", "res://Assets/Agriculture/Plants/Sugarcane-4.png", "res://Assets/Agriculture/Plants/Sugarcane-full.png"]

var growing_stage = 0
var final_stage = 2

func _ready():
	$Sprite.texture = load(filenames_array[growing_stage])

func _on_Timer_timeout():
	growing_stage += 1
	$Sprite.texture = load(filenames_array[growing_stage])
	if growing_stage == final_stage:
		print("Grown")
		$Timer.stop()
