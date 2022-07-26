extends Node2D
class_name Pedestrians
export var health = 10
enum{
	IDLE,
	NEW_DIRECTION,
	MOVE
}
export var SPEED = 100
var state = MOVE
var direction = Vector2.RIGHT

func _ready():
	randomize()
	
func _process(delta):
	match state:
		IDLE:
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

func _on_Timer_timeout():
	$KinematicBody2D/Timer.wait_time = choose([0.5, 1, 1.5])
	state = choose([IDLE, NEW_DIRECTION, MOVE])
