extends CharacterBody2D

class_name Player

var SPEED = 300
const GROUP_NAME: String = "Player"

@export var inventory: Inv = preload("res://Scenes/Inventory/player_inventory.tres")

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

func _ready() -> void:
	SignalHub.item_collected.connect(_on_item_collected)

func get_input() -> Vector2:
	var nv: Vector2 = Vector2.ZERO
	nv.x = Input.get_axis("left", "right")
	nv.y = Input.get_axis("up", "down")
	return nv.normalized()

func _physics_process(_delta: float) -> void:
	velocity = get_input() * SPEED
	rotation = velocity.angle()
	move_and_slide()

func _on_item_collected(collected_item: InvItem) -> void: 
	inventory.insert(collected_item)
