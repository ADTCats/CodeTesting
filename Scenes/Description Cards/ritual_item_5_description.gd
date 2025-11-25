extends DescriptionBase

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("continue") == true:
		hide()
		get_tree().paused = false

func _ready() -> void:
	hide()
	SignalHub.on_ritualitem5_pickup.connect(_on_ritualitem5_pickup)
	SignalHub.ritualitem5_description.connect(_on_ritualitem5_description)

func _on_ritualitem5_pickup() -> void:
	get_tree().paused = true
	show()

func _on_ritualitem5_description(_item: InvItem) -> void: 
	get_tree().paused = true
	show()
