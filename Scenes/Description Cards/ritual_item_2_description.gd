extends DescriptionBase

#func _unhandled_input(event: InputEvent) -> void:
	#super._unhandled_input(event)
	#if event.is_action_pressed("continue") == true:
		#hide()
		#get_tree().paused = false
# moved this logic over to the DescriptionBase script

func _ready() -> void:
	super._ready()
	hide()
	SignalHub.on_ritualitem2_pickup.connect(_on_ritualitem2_pickup)
	SignalHub.ritualitem2_description.connect(_on_ritualitem2_description)

func _exit_tree():
	#super._exit_tree()
	if SignalHub.on_ritualitem2_pickup.is_connected(_on_ritualitem2_pickup):
		SignalHub.on_ritualitem2_pickup.disconnect(_on_ritualitem2_pickup)
	if SignalHub.ritualitem2_description.is_connected(_on_ritualitem2_description):
		SignalHub.ritualitem2_description.disconnect(_on_ritualitem2_description)


func _on_ritualitem2_pickup() -> void:
	get_tree().paused = true
	show()

func _on_ritualitem2_description(_item: InvItem) -> void: 
	safe_pause()
	show()
