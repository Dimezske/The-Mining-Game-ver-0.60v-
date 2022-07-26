extends Node2D
class_name StateMachine

var state_machine = null

var player: Player = null
var getPlayer = get_owner()
var player_velocity = Vector2()
var player_speed = 200
var player_energy = 50

enum STATES{IDLE, WALK, RUN, USE, SHOOT}
var state: int
var parent = get_parent()

func _physics_process(_delta):
	match state:
	   STATES.IDLE:
		   state = STATES.IDLE
	   STATES.WALK:
		   state = STATES.WALK
	   STATES.RUN:
		   state = STATES.RUN
	   STATES.USE:
		   state = STATES.USE
	   STATES.SHOOT:
		   state = STATES.SHOOT

func set_state(new_value:int) -> void:
	if state == new_value:
		return
	var _name = STATES.keys()[new_value]
	var method_name:String = "on_" + STATES.keys()[new_value]
	
	if has_method(method_name):
		call_deferred(method_name)

	state = new_value

func on_IDLE() -> void:
	STATES.IDLE = $Idle
	print("IS IDLING")
func on_WALK() -> void:
	STATES.WALK = $Walk
	player_speed = 200
	print("IS WALKING")
func on_RUN() -> void:
	STATES.RUN = $Run
	player_speed = 300
	print("IS RUNNING")
func on_USE() -> void:
	STATES.USE = $Use
	print("IS USING")
func on_SHOOT() -> void:
	STATES.SHOOT = $Shoot
	print("IS SHOOTING")
