extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("continue") == true:
		hide()
		get_tree().paused = false

func _ready() -> void:
	hide()
	SignalHub.on_newspaper_pickup.connect(_on_newspaper_pickup)

func _on_newspaper_pickup() -> void:
	get_tree().paused = true
	show()
