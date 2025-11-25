extends DescriptionBase

#func _unhandled_input(event: InputEvent) -> void:
	#super._unhandled_input(event)
	#if event.is_action_pressed("continue") == true:
		#hide()
		#get_tree().paused = false

func _ready() -> void:
	super._ready()
	hide()
	SignalHub.on_ritualitem2_pickup.connect(_on_ritualitem2_pickup)
	SignalHub.ritualitem2_description.connect(_on_ritualitem2_description)

func _on_ritualitem2_pickup() -> void:
	get_tree().paused = true
	show()

func _on_ritualitem2_description(_item: InvItem) -> void: 
	#get_tree().paused = true
	show()
