extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay
var slot_data: InvSlot

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	print("Slot ready! Mouse filter: ", mouse_filter)
	$CenterContainer/Panel.mouse_filter = Control.MOUSE_FILTER_IGNORE

func update(slot: InvSlot): 
	slot_data = slot
	
	if slot == null:
		item_visual.visible = false
		return
	
	if !slot.item: 
		item_visual.visible = false 
	else:
		item_visual.visible = true 
		item_visual.texture = slot.item.texture

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		var rect = get_global_rect()
		if rect.has_point(mouse_pos):
			print("Clicked on slot!")
			if slot_data != null and slot_data.item != null: 
				_on_slot_clicked()
				get_viewport().set_input_as_handled()

#func _gui_input(event: InputEvent) -> void:
	#print("GUI Input received: ", event)
	#if event is InputEventMouseButton:
		#print("Mouse button event!")
		#if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			#print("Left click detected!")
			#if slot_data != null and slot_data.item != null:
				#_on_slot_clicked()

func _on_slot_clicked():
	print("Slot clicked! Item: ", slot_data.item.name)
	SignalHub.emit_item_description(slot_data.item)
