extends CanvasLayer

var holding_item = null
var mouse_over_slot = false

func _input(event):
	if event.is_action_pressed("Inventory"):
		$Inventory.visible = !$Inventory.visible
		if !$Inventory.visible:
			mouse_over_slot = false
		$Inventory.initialize_inventory()
	if event.is_action_pressed("new_inventory"):
		$Hotbar.visible = !$Hotbar.visible
		$Hotbar.initialize_hotbar()
	if event.is_action_pressed("status_bar"):
		$Status.visible = !$Status.visible
#	if OS.is_window_minimized()  == true:
#
	if OS.is_window_maximized() == true:
		$Inventory.position = Vector2(300,200)
		$Hotbar.position = Vector2(300,400)
	else:
		$Hotbar.position = Vector2(0,0)
		$Inventory.position = Vector2(0,0)
	
	if OS.window_fullscreen == true:
		$Inventory.position = Vector2(300,200)
		$Hotbar.position = Vector2(300,435)
	else:
		$Hotbar.position = Vector2(0,0)
		$Inventory.position = Vector2(0,0)
		
	if event.is_action_pressed("full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen
			
	if event.is_action_pressed("scroll_up"):
		PlayerInventory.active_item_scroll_down()
	elif event.is_action_pressed("scroll_down"):
		PlayerInventory.active_item_scroll_up()
		
func _ready():
		pass
		
		
#bool window_fullscreen [default: false]
#set_window_fullscreen(value)
#setteris_window_fullscreen() getter

