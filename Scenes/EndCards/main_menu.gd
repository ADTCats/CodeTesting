extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("continue") == true: 
		ProgressionManager.start_new_game()

func _ready() -> void:
	pass
