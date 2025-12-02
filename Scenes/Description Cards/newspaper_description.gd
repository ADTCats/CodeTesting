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
	SignalHub.on_newspaper_pickup.connect(_on_newspaper_pickup)
	SignalHub.newspaper_description.connect(_on_newspaper_description)

func _exit_tree():
	super._exit_tree() 
	if SignalHub.on_newspaper_pickup.is_connected(_on_newspaper_pickup):
		SignalHub.on_newspaper_pickup.disconnect(_on_newspaper_pickup)
	if SignalHub.newspaper_description.is_connected(_on_newspaper_description):
		SignalHub.newspaper_description.disconnect(_on_newspaper_description)


func _on_newspaper_pickup() -> void:
	get_tree().paused = true
	show()

func _on_newspaper_description(_item: InvItem) -> void:
	print("NEWSPAPER DESCRIPTION RECEIVED SIGNAL")
	print("My tree: ", get_tree())
	print("Am I in scene tree: ", is_inside_tree())
	safe_pause()
	show()
