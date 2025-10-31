extends Area2D
class_name InteractableArea

@export var required_item: InvItem
@export var area_name: String = "Interactable Area"
@export var prompt_text: String = "Press E to Interact"

var player_in_range: bool = false 
var player_reference: Player = null

signal item_placed(item: InvItem, area: InteractableArea)

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D):
	if body is Player: 
		player_in_range = true
		player_reference = body
		show_prompt()

func _on_body_exited(body: Node2D):
	if body is Player: 
		player_in_range = false
		player_reference = null
		hide_prompt()

func open_inventory_for_placement():
	SignalHub.emit_open_inventory_for_placement(self)

func show_prompt():
	SignalHub.emit_show_interaction_prompt(prompt_text)

func hide_prompt():
	SignalHub.emit_hide_interaction_prompt()

func place_item(item: InvItem) -> bool: 
	if required_item != null and item != required_item:
		print("This area doesn'ta ccept that item!")
		return false
		
	item_placed.emit(item, self)
	print("Item placed:", item.name)
	return true
