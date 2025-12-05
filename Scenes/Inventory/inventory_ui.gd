extends Control

var is_open = false 
var placement_mode = false 
var current_interactable_area: InteractableArea = null

const GROUP_NAME: String = "InventoryUI"

#@onready var slots: Array = $NinePatchRect/GridContainer
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var grid_container: GridContainer = $NinePatchRect/GridContainer

#@export var inv: Inv = preload("res://Scenes/Inventory/player_inventory.tres")

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)
	InventoryManager.inventory_ui = self

func _ready() -> void:
	close()
	if InventoryManager.inventory:
		InventoryManager.inventory.update.connect(update_slots)
		update_slots()
	SignalHub.open_inventory_for_placement.connect(_on_open_for_placement)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("open inventory"):
		if is_open:
			close()
		else:
			open()

func open():
	safe_pause()
	self.visible = true 
	is_open = true

func open_for_placement(area: InteractableArea):
	placement_mode = true 
	current_interactable_area = area
	safe_unpause()
	self.visible = true
	is_open = true
	#print("Inventory opene in placement mode for: ", area.area_name)

func close():
	placement_mode = false
	current_interactable_area = null
	safe_unpause()
	visible = false 
	is_open = false

func update_slots():
	#print("=== Updating inventory UI slots ===")
	#var slots = grid_container.get_children()
	var inv = InventoryManager.inventory
	for i in range(min(inv.slots.size(), slots.size())):
		var slot_data = inv.slots[i]
		var ui_slot = slots[i]
		ui_slot.slot_index = i
		if slot_data == null:
			#print("Slot ", i, ": null slot_data")
			continue
		#print("Slot ", i, ": item = ", slot_data.item, " | amount = ", slot_data.amount if slot_data.item else 0)
		slots[i].update(inv.slots[i])


func _on_open_for_placement(area: InteractableArea):
	open_for_placement(area)

func try_place_item(slot_index: int):
	if not placement_mode or current_interactable_area == null: 
		return 
	
	var inv = InventoryManager.inventory
	var slot_data = inv.slots[slot_index]
	if slot_data == null or slot_data.item == null: 
		return
	
	if current_interactable_area.place_item(slot_data.item):
		InventoryManager.remove_item(slot_index)
		close()



func safe_pause():
	if not is_inside_tree():
		return
	var tree = get_tree()
	if tree:
		tree.paused = true

func safe_unpause():
	if not is_inside_tree():
		return
	var tree = get_tree()
	if tree:
		tree.paused = false
