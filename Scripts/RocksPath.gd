extends Path2D


enum {
	MOVE
	SLOW
	GRINDING
	EXIT
}
onready var mineRocks = $PathFollow2D/MineRocks
var copper_mineral = preload("res://CopperMinerals.tscn")
var timer_counter = 0
var time_to_grind = 4
export var SPEED = 100
var state = MOVE
var move_direction = 0
onready var path_follow = get_child(0)

func _ready():
	mineRocks.can_be_picked = false

func _physics_process(delta):
	if timer_counter >= time_to_grind:
		state = EXIT
	if state == MOVE:
		timer_counter = 0
	match state:
		MOVE:
			move(delta, SPEED)
			if path_follow.get_offset() > 220:
				state = SLOW
		SLOW:
			move(delta, SPEED * 0.5)
			if path_follow.get_offset() > 370:
				state = GRINDING
				path_follow.remove_child(path_follow.get_child(0))
				var new_item = copper_mineral.instance()
				path_follow.add_child(new_item)
		GRINDING:
			$RockSplatter.visible = true
		EXIT:
			move(delta, SPEED * 0.7)
			$RockSplatter.visible = false
func move(delta, spd):
	var prepos = path_follow.get_global_position()
	path_follow.set_offset(path_follow.get_offset()+spd*delta)
	var pos = path_follow.get_global_position()
	move_direction = (pos.angle_to_point(prepos) / 3.14) * 180

func _on_Timer_timeout():
	if state == GRINDING:
		timer_counter += 1
