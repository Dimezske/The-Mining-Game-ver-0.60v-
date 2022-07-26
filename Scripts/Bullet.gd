extends RigidBody2D
var player_in_range : bool
var pedestrian_in_range : bool
var damage = 2.5

func _physics_process(_delta):
	pass


func _on_Bullet_body_entered(body):
	if body.name == "Character" or body.name == "Pedestrians":
		if body.name == "Character":
			print("player detected")
			player_in_range = true
		if body.name == "Pedestrian":
			print("pedestrian detected")
			pedestrian_in_range = true
			Pedestrians.health -= damage
			print("2.5dam")
