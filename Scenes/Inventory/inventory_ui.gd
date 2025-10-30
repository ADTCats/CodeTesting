extends Control

var is_open = false 

@export var inv: Inv
#@onready var slots: Array = $NinePatchRect/GridContainer
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var grid_container: GridContainer = $NinePatchRect/GridContainer

func _ready() -> void:
	close()
	if inv:
		inv.update.connect(update_slots)
		update_slots()


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

func close():
	get_tree().paused = false
	visible = false 
	is_open = false

func update_slots():
	var slots = grid_container.get_children()
	for i in range(min(inv.slots.size(), slots.size())):
		#var slot_data = inv.slots[i]
		#if slot_data == null:
			#continue
		slots[i].update(inv.slots[i])
