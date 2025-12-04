extends Control

func _on_continue_button_pressed():
	ProgressionManager.start_new_game()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("continue"):
		ProgressionManager.start_new_game()
