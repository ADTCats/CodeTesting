extends DescriptionBase

#func _unhandled_input(event: InputEvent) -> void:
	#super._unhandled_input(event)
	#if event.is_action_pressed("continue") == true:
		#hide()
		#get_tree().paused = false

func _ready() -> void:
	super._ready()
	hide()
	SignalHub.on_newspaper_pickup.connect(_on_newspaper_pickup)
	SignalHub.newspaper_description.connect(_on_newspaper_description)

func _on_newspaper_pickup() -> void:
	get_tree().paused = true
	show()

func _on_newspaper_description(_item: InvItem) -> void: 
	print("Newspaper: _on_newspaper_description called")
	show()
