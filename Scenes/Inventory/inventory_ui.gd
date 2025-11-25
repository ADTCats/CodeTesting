extends Control

var is_open = false 
var placement_mode = false 
var current_interactable_area: InteractableArea = null

const GROUP_NAME: String = "InvenotryUI"

#@onready var slots: Array = $NinePatchRect/GridContainer
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var grid_container: GridContainer = $NinePatchRect/GridContainer

@export var inv: Inv = preload("res://Scenes/Inventory/player_inventory.tres")

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

func _ready() -> void:
	close()
	if inv:
		inv.update.connect(update_slots)
		update_slots()
		SignalHub.open_inventory_for_placement.connect(_on_open_for_placement)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("open inventory"):
		if is_open:
			close()
		else:
			open()

func open():
	get_tree().paused = true
	self.visible = true 
	is_open = true

func open_for_placement(area: InteractableArea):
	placement_mode = true 
	current_interactable_area = area
	get_tree().paused = true
	self.visible = true
	is_open = true
	#print("Inventory opene in placement mode for: ", area.area_name)

func close():
	placement_mode = false
	current_interactable_area = null
	get_tree().paused = false
	visible = false 
	is_open = false

func update_slots():
	#var slots = grid_container.get_children()
	for i in range(min(inv.slots.size(), slots.size())):
		var slot_data = inv.slots[i]
		var ui_slot = slots[i]
		ui_slot.slot_index = i
		if slot_data == null:
			continue
		slots[i].update(inv.slots[i])

func _on_open_for_placement(area: InteractableArea):
	open_for_placement(area)

func try_place_item(slot_index: int):
	if not placement_mode or current_interactable_area == null: 
		return 

	var slot_data = inv.slots[slot_index]
	if slot_data == null or slot_data.item == null: 
		return
	
	if current_interactable_area.place_item(slot_data.item):
		inv.remove_item(slot_index)
		close()
	
