extends Control

class_name DescriptionBase

var is_final_ritual_item: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("continue"):
		hide()
		var inventory_ui = get_tree().get_first_node_in_group("InventoryUI")
		if inventory_ui == null or not inventory_ui.is_open:
			safe_unpause()
		#safe_unpause()
# commenting out this line and adding the above code piece, 
# since the logic to have the game pause when an item
# is first picked up and the description card is shown is already in place, this
# line was causing the game to stop being paused when you pressed on a item
# in your inventory, making the game unpaused once you dismissed the description 
# card, but the inventory is still open. 
# WHOOHOO FOR A SIMPLE FIX!!! 
		# Check if this was the final ritual item
		if is_final_ritual_item:
			# Add delay before showing ritual complete card
			await get_tree().create_timer(1.0).timeout
			ProgressionManager.show_ritual_complete_screen()

func _ready() -> void: 
	hide()
	SignalHub.ritual_complete.connect(_on_ritual_complete)

#func _exit_tree():
	#if SignalHub.ritual_complete.is_connected(_on_ritual_complete):
		#SignalHub.ritual_complete.disconnect(_on_ritual_complete)


func _on_item_pickup() -> void: 
	safe_pause()
	show()
	is_final_ritual_item = false 

func _on_ritual_complete() -> void: 
	is_final_ritual_item = true



func safe_pause():
	var tree = get_tree()
	print("safe_pause called. Tree exists: ", tree != null)
	if tree:
		print("Pausing tree")
		tree.paused = true
	else:
		print("ERROR: Tree is null!")

func safe_unpause():
	var tree = get_tree()
	print("safe_unpause called. Tree exists: ", tree != null)
	if tree:
		print("Unpausing tree")
		tree.paused = false
	else:
		print("ERROR: Tree is null!")
