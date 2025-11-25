extends Control

class_name DescriptionBase

var is_final_ritual_item: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("continue"):
		hide()
		safe_unpause()
		
		# Check if this was the final ritual item
		if is_final_ritual_item:
			# Add delay before showing ritual complete card
			await get_tree().create_timer(1.0).timeout
			ProgressionManager.show_ritual_complete_screen()

func _ready() -> void: 
	hide()
	SignalHub.ritual_complete.connect(_on_ritual_complete)

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
