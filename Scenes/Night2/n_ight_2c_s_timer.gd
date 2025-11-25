extends TimerUIBase


func _ready() -> void:
	SignalHub.night_02_complete.connect(night_02_complete)
	super._ready()


func night_02_complete() -> void: 
	GameManager.load_night2survived_scene()

func _on_timer_12_timeout() -> void: 
	ProgressionManager.timer_ran_out()
