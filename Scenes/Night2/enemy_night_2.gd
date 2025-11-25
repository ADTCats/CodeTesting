extends EnemyBase

func _ready() -> void:
	super._ready()

func player_caught() -> void: 
	GameManager.load_night2caught_scene()
