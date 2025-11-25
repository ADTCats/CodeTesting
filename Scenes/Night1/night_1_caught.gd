extends Control

func _on_continue_button_pressed():
	ProgressionManager.continue_to_next_night()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("continue"):
		ProgressionManager.continue_to_next_night()

#func _on_continue_button_pressed():
	#ProgressionManager.load_normal_night(2)
#
#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("continue") == true: 
		#ProgressionManager.continue_to_next_night()
