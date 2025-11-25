extends CharacterBody2D

class_name EnemyBase

const FOV: float = 120.0

@onready var player_detect: RayCast2D = $PlayerDetect
@onready var debug: Label = $Debug

const DETECTION_RANGE: float = 236.0

var _player_ref: Player
var _facing_direction: Vector2 = Vector2.RIGHT
var _has_caught_player: bool = false

func _ready() -> void:
	SignalHub.player_caught.connect(player_caught)
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if !_player_ref:
		queue_free()
		return
	
	#print("Player collision_layer: ", _player_ref.collision_layer)
	#print("Player collision_mask: ", _player_ref.collision_mask)
	
	#for child in _player_ref.get_children():
		#if child is CollisionShape2D:
			#print("Found CollisionShape2D: ", child.name, " | Disabled: ", child.disabled)
	
	
	player_detect.enabled = true
	player_detect.set_collision_mask_value(1, true)
	player_detect.target_position = _facing_direction * DETECTION_RANGE

	#print("RayCast collision mask: ", player_detect.collision_mask)
	#print("Player collision layer: ", _player_ref.collision_layer)

func _physics_process(_delta: float) -> void: 
	set_label()
	update_raycast()

func get_fov_angle() -> float: 
	var dtp: Vector2 = global_position.direction_to(_player_ref.global_position)
	var atp: float = _facing_direction.angle_to(dtp)
	return rad_to_deg(atp)

func update_raycast() -> void: 
	var direction_to_player = global_position.direction_to(_player_ref.global_position)
	var distance_to_player = global_position.distance_to(_player_ref.global_position)
	
	
	player_detect.target_position = direction_to_player * min(distance_to_player + 50, DETECTION_RANGE)
	
	#print("Enemy at: ", global_position)
	#print("Player at: ", _player_ref.global_position)
	#print("Direction: ", direction_to_player)
	#print("Raycast target (local): ", player_detect.target_position)
	
	player_detect.force_raycast_update()
	
	#var collider = player_detect.get_collider()
	#if collider:
		#print("Raycast Hit: ", collider.name, " | Type: ", collider.get_class())
	#else: 
		#print("Raycast hit nothing")
	
	if can_see_player() and not _has_caught_player:
		_has_caught_player = true
		SignalHub.emit_player_caught()

func player_is_visible() -> bool: 
	return player_detect.get_collider() and player_detect.get_collider() is Player

func can_see_player() -> bool: 
	var within_fov = abs(get_fov_angle()) < FOV / 2.0
	return within_fov and player_is_visible()

func detect_player() -> void: 
	pass

func player_caught() -> void: 
	ProgressionManager.player_was_caught()





func set_label():
	var s: String = "%s Fin:%s\n"
	s += "VIZ:%s FOV:%.0f\n" % [player_is_visible(), get_fov_angle()]
	s += "CanSee?:%s\n" % can_see_player()
	debug.text = s
	debug.rotation = -rotation
