tool
extends Control

onready var progress : ProgressBar = $Progress
onready var display : Label = $Progress/Label

func _ready():
	progress.min_value = 0;
	progress.max_value = 10;
	progress.value = 10;
	display.text = "%d/%d" % [progress.value,progress.max_value]

func update_health(value : int):
	progress.value = value
	display.text = "%d/%d" % [progress.value,progress.max_value]

func update_max_health(value : int):
	progress.max_value = value
	progress.value = clamp(progress.value, 0, value)
	display.text = "%d/%d" % [progress.value, progress.max_value]
