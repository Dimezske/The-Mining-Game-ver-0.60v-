extends CanvasLayer

var lazerDesignatorBeamParticle = preload("res://Materials/LazerDesignator.tres")

var materials = [lazerDesignatorBeamParticle]

func _ready():
	for material in materials:
		var particals_instance = Particles2D.new()
		particals_instance.set_process_material(material)
		particals_instance.set_one_shot(true)
		particals_instance.set_modulate(Color(1,1,1,0))
		particals_instance.set_emitting(true)
		self.add_child(particals_instance)
