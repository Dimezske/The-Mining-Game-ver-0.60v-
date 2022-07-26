extends CanvasLayer

const INVENTORY_ITEM_SCENE: PackedScene = preload("res://InventoryItem.tscn")
const MIN_HEALTH: int = 23

var Health : int = 100
var Max_Health = 100

onready var player: KinematicBody2D = get_owner().get_node(".")
onready var health_bar: TextureProgress = get_node("Control/HealthOver")
#onready var health_bar: ProgressBar = get_node("UI/Control/HealthBar")
onready var health_bar_tween: Tween = get_node("Control/Tween")
#onready var health_bar_tween: Tween = get_node("UI/Control/HealthBar/Tween")

#onready var inventory: HBoxContainer = get_node("PanelContainer/Inventory")

func _ready():
	#_update_health_bar(100)
	pass
func _update_health_bar(new_value: int):
	var __ = health_bar_tween.interpolate_property(health_bar, "value", health_bar.value,
	new_value, 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	__ = health_bar_tween.start()
	
func on_Character_hp_changed(new_hp: int):
	var new_health: int = int((100 - Health) * float(new_hp) / Max_Health) + MIN_HEALTH
	_update_health_bar(new_health)


