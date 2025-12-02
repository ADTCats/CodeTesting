extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay
var slot_data: InvSlot
var slot_index: int = 0 

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	#print("Slot ready! Mouse filter: ", mouse_filter)
	$CenterContainer/Panel.mouse_filter = Control.MOUSE_FILTER_IGNORE

func update(slot: InvSlot): 
	slot_data = slot
	if slot == null:
		item_visual.visible = false
		return
	
	if slot.item == null or slot.amount <= 0: 
		item_visual.visible = false 
		slot_data = null
		return
	
	item_visual.visible = true 
	item_visual.texture = slot.item.texture

func _input(event: InputEvent) -> void:
	if not is_inside_tree():  # Add this check at the top
		return
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		var rect = get_global_rect()
		if rect.has_point(mouse_pos):
			if slot_data != null and slot_data.item != null: 
				_on_slot_clicked()
				var viewport = get_viewport()
				if viewport:
					viewport.set_input_as_handled()

#func _gui_input(event: InputEvent) -> void:
	#print("GUI Input received: ", event)
	#if event is InputEventMouseButton:
		#print("Mouse button event!")
		#if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			#print("Left click detected!")
			#if slot_data != null and slot_data.item != null:
				#_on_slot_clicked()

func _on_slot_clicked():
	if not is_inside_tree():
		return
	
	var inventory_ui = get_tree().get_first_node_in_group("InventoryUI")
	
	if inventory_ui == null:
		#print("ERROR: Can't find InventoryUI!")
		return
	
	if inventory_ui.placement_mode:
		#print("Placement mode - trying to place item", slot_data.item.name)
		inventory_ui.try_place_item(slot_index)
	else:
		match slot_data.item.name:
			"Newspaper":
				SignalHub.emit_newspaper_description(slot_data.item)
			"RitualItem2":
				SignalHub.emit_ritualitem2_description(slot_data.item)
			"RitualItem3":
				SignalHub.emit_ritualitem3_description(slot_data.item)
			"RitualItem4":
				SignalHub.emit_ritualitem4_description(slot_data.item)
			"RitualItem5":
				SignalHub.emit_ritualitem5_description(slot_data.item)
			"RitualItem6":
				SignalHub.emit_ritualitem6_description(slot_data.item)
