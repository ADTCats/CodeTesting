extends Area2D
class_name InteractableArea

@export var required_item: InvItem
@export var area_name: String = "Interactable Area"
@export var place_prompt_text: String = "Press E to Place Item"
@export var pickup_prompt_text: String = "Press E to Pick Up Item"

@onready var pickup_text: Label = $pickup_text
@onready var place_text: Label = $place_text
#@onready var place_text: Label = $Label
@onready var item_display: Sprite2D = $ItemDisplay

var player_in_range: bool = false 
var player_reference: Player = null
var placed_item: InvItem = null

signal item_placed(item: InvItem, area: InteractableArea)
signal item_picked_up(item: InvItem, area: InteractableArea)

func _ready():
	place_text.hide()
	pickup_text.hide()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	if item_display:
		item_display.visible = false

func _on_body_entered(body: Node2D):
	#print("Body entered area: ", body.name, " | Is Player? ", body is Player)
	if body is Player: 
		player_in_range = true
		player_reference = body
		show_appropriate_prompt()

func _on_body_exited(body: Node2D):
	if body is Player: 
		player_in_range = false
		player_reference = null
		hide_prompt()

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if placed_item == null:
			open_inventory_for_placement()
		else:
			pick_up_item()

func open_inventory_for_placement():
	SignalHub.emit_open_inventory_for_placement(self)

func show_appropriate_prompt():
	if placed_item == null:
		SignalHub.emit_show_interaction_prompt(place_prompt_text)
		place_text.show()
		pickup_text.hide()
	else:
		SignalHub.emit_show_interaction_prompt(pickup_prompt_text)
		pickup_text.show()
		place_text.hide()

func hide_prompt():
	SignalHub.emit_hide_interaction_prompt()
	place_text.hide()


func place_item(item: InvItem) -> bool: 
	if required_item != null and item != required_item:
		#print("This area doesn't accept that item!")
		return false
	
	placed_item = item
	
	if item_display:
		item_display.texture = item.texture
		item_display.visible = true
	
	item_placed.emit(item, self)
	#print("Item placed:", item.name)
	if player_in_range:
		show_appropriate_prompt()
	return true

func pick_up_item():
	if placed_item == null: 
		return 
	
	if player_reference and player_reference.inventory:
		player_reference.inventory.insert(placed_item)
		print("Picked up: ", placed_item.name)
		
		item_picked_up.emit(placed_item, self)
		
		placed_item = null 
		
		if item_display:
			item_display.visible = false 
		
		if player_in_range:
			show_appropriate_prompt()
