extends Node2D
class_name TacticalResponsePatrol
export(Texture) var enemy_texture = null
export(String) var enemy_name = "(TRT)Tactical Response Unit"
# export variables can be set from the editor
export(Vector2) var enemy_texture_size = Vector2(50,50)

const SPEED = 100
onready var health = 150
onready var max_health = 150
enum{
	IDLE,
	NEW_DIRECTION,
	MOVE
}
var state = MOVE
var direction = Vector2.RIGHT
var Character = null
func _ready():
	randomize()
	
func _process(delta):
	match state:
		IDLE:
			#move(delta)
			if direction == choose([Vector2.RIGHT]):
				$AnimationPlayer.stop()
				$AnimationPlayer.play("idle-right")
			if direction == choose([Vector2.LEFT]):
				$AnimationPlayer.stop()
				$AnimationPlayer.play("idle-left")
			if direction == choose([Vector2.UP]):
				$AnimationPlayer.stop()
				$AnimationPlayer.play("idle-up")
			if direction == choose([Vector2.DOWN]):
				$AnimationPlayer.stop()
				$AnimationPlayer.play("idle-down")
			
		NEW_DIRECTION:
			direction = choose([Vector2.RIGHT, Vector2.UP,Vector2.LEFT, Vector2.DOWN])
			state = choose([IDLE, MOVE])
			if direction == choose([Vector2.RIGHT]):
				$AnimationPlayer.play("idle-right")
			if direction == choose([Vector2.LEFT]):
				$AnimationPlayer.play("idle-left")
			if direction == choose([Vector2.UP]):
				$AnimationPlayer.play("idle-up")
			if direction == choose([Vector2.DOWN]):
				$AnimationPlayer.play("idle-down")
			
		MOVE:
			move(delta)
			if direction == choose([Vector2.RIGHT]):
				$AnimationPlayer.play("walk-right")
			if direction == choose([Vector2.LEFT]):
				$AnimationPlayer.play("walk-left")
			if direction == choose([Vector2.UP]):
				$AnimationPlayer.play("walk-up")
			if direction == choose([Vector2.DOWN]):
				$AnimationPlayer.play("walk-down")
				
			
func move(delta):
	position += direction * SPEED * delta
	
func choose(array):
	array.shuffle()
	return array.front()
func _on_DetectPlayer_body_entered(body):
	if body.name == "Player":
		Character = body
		#animationTree.active = true
		EventBus.emit_signal("player_detected", self)
func _on_DetectPlayer_body_exited(body):
	if body.name == "Player":
		Character = null
		#animationTree.active = false
		EventBus.emit_signal("player_exited", self)
		
func _on_Timer_timeout():
	$KinematicBody2D/Timer.wait_time = choose([0.5, 1, 1.5])
	state = choose([IDLE, NEW_DIRECTION, MOVE])

func _on_DetectPlayer_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and Input.is_action_just_pressed("use"):
		EventBus.emit_signal("show_ui_for_enemy", self)
		get_tree().set_input_as_handled()
