extends Node

var inventory: Inv 
var inventory_ui: Control 

func _ready():
	inventory = preload("res://Scenes/Inventory/player_inventory.tres")
	inventory.update.connect(_on_inventory_updated)

func add_item(item: InvItem):
	inventory.insert(item)

func remove_item(slot_index:int):
	inventory.remove_item(slot_index)

func clear_inventory():
	inventory.slots.clear()
	inventory._ensure_slots_initalized()
	inventory.update.emit()

func get_inventory() -> Inv: 
	return inventory 

func _on_inventory_updated():
	SignalHub.inventory_updated.emit()
