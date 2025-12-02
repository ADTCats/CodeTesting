extends TimerUIBase


func _ready() -> void:
	SignalHub.night_03_complete.connect(night_03_complete)
	super._ready()


func night_03_complete() -> void: 
	GameManager.load_endsurvived_scene()

func _on_timer_12_timeout() -> void: 
	ProgressionManager.timer_ran_out()
