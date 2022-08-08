extends Node2D

onready var Red = Color(255,0,0,255)
onready var Green = Color(0,255,0,255)
onready var Blue = Color(0,0,255,255)

var player_node 
var player_initial_map_position = Vector2(200,200)
#var getlevel_start = preload("res://Scenes/Startmine.tscn")
var player_direction = ["LEFT","RIGHT","UP","DOWN"]
var player_velocity = Vector2()
var player_speed

var player_isIdle : bool
var player_isWalking : bool
var player_isRunning : bool
var player_isUsing : bool
var player_isShooting : bool

var player_pickedUpItem : bool
var player_DropItem : bool

var pressed_button

var hasM4a1 : bool
var hasMiningDrill : bool

func _ready():
#	var level_path = get_tree().root.get_node("root/Game")
#	level_path.get_tree().current_scene.name == "res://Scenes/OutsideWorld.tscn"
	#if get_tree().current_scene.filename == "res://Scenes/OutsideWorld.tscn":
		#player_initial_map_position = Vector2(4000,1000)
	pass
