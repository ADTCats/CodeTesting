extends CharacterBody2D

class_name Player

var SPEED = 300
const GROUP_NAME: String = "Player"

@export var inventory: Inv = preload("res://Scenes/Inventory/player_inventory.tres")

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

func _ready() -> void:
	#print("=== PLAYER READY ===")
	#print("Player instance: ", self)
	#print("Player path: ", get_path())
	
	if SignalHub.item_collected.is_connected(_on_item_collected):
		SignalHub.item_collected.disconnect(_on_item_collected)
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
	#print("=== PLAYER RECEIVED ITEM ===")
	#print("Player: ", get_path())
	#print("Item: ", collected_item.name if collected_item else "null")
	#
	inventory.insert(collected_item)

func _exit_tree() -> void:
	if SignalHub.item_collected.is_connected(_on_item_collected):
		SignalHub.item_collected.disconnect(_on_item_collected)
# A huge issue you were having earlier was duplicated items: 
# This line disconnected the item collection signal when you transition your player
# from one scene to the next - a good rule of thumb going forward is if you have a 
# _ready_ call that is hooked up to a persistent character, you need to have this 
# _exit_tree call to disconnect that signal. That's why you'd have 2 item duplicates
# in Night 2 (you had the Night 1 player character AND the Night 2 character emitting
# that signal) and 3 item duplicates in Night 3 (3 characters emitting) 
