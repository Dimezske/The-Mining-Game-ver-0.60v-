extends TextureRect

onready var border: ReferenceRect = get_node("ReferenceRect")

func initialize(texture: Texture):
	self.texture = texture
	
func select():
	border.show()
	
func deselect():
	border.hide()
