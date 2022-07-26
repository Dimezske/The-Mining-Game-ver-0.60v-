extends Node

const NUM_ENEMY_SLOTS = 1
var enemy_user_display = {
#	0: ["M4", 1],  #--> slot_index: [item_name, item_quantity]
#	1: ["M4", 1]  #--> slot_index: [item_name, item_quantity]
}
func _ready():
	pass # Replace with function body.

func add_item(enemy_name):
	var slot_indices: Array = enemy_user_display.keys()
	slot_indices.sort()
	for enemy in slot_indices:
		if enemy_user_display[enemy] == enemy_name:
			var stack_size = int(JsonData.enemy_data[enemy_name])
			var able_to_add = enemy_user_display[enemy]
			if able_to_add >= [enemy_name]:
				enemy_user_display[enemy][1] += [enemy_name]
				update_slot_visual(enemy, enemy_user_display[enemy], enemy_user_display[enemy])
				return
			else:
				enemy_user_display[enemy] += able_to_add
				update_slot_visual(enemy, enemy_user_display[enemy], enemy_user_display[enemy])
				[enemy_name] = [enemy_name] - able_to_add
	
	# item doesn't exist in inventory yet, so add it to an empty slot
	for i in range(NUM_ENEMY_SLOTS):
		if enemy_user_display.has(i) == false:
			enemy_user_display[i] = [enemy_name, enemy_name]
			update_slot_visual(i, enemy_user_display[i], enemy_user_display[i])
			return

func update_slot_visual(slot_index, enemy_name, new_enemy):
	var slot = get_tree().root.get_node("/root/EnemyStatus" + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(enemy_name, new_enemy)
	else:
		slot.initialize_item(enemy_name, new_enemy)
