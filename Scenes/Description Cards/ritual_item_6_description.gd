extends DescriptionBase

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("continue") == true:
		#hide()
		#get_tree().paused = false
# moved this logic over to the DescriptionBase script

func _ready() -> void:
	super._ready()
	hide()
	SignalHub.on_ritualitem6_pickup.connect(_on_ritualitem6_pickup)
	SignalHub.ritualitem6_description.connect(_on_ritualitem6_description)

func _exit_tree():
	#super._exit_tree()
	if SignalHub.on_ritualitem6_pickup.is_connected(_on_ritualitem6_pickup):
		SignalHub.on_ritualitem6_pickup.disconnect(_on_ritualitem6_pickup)
	if SignalHub.ritualitem6_description.is_connected(_on_ritualitem6_description):
		SignalHub.ritualitem6_description.disconnect(_on_ritualitem6_description)

func _on_ritualitem6_pickup() -> void:
	get_tree().paused = true
	show()

func _on_ritualitem6_description(_item: InvItem) -> void: 
	get_tree().paused = true
	show()
