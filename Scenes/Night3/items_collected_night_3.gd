extends Control

func _on_continue_button_pressed():
	ProgressionManager.continue_to_ritual_night()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("continue"):
		ProgressionManager.continue_to_ritual_night()
