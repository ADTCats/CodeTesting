extends TimerUIBase


func _ready() -> void:
	SignalHub.night_01_complete.connect(night_01_complete)
	super._ready()


func night_01_complete() -> void: 
	GameManager.load_night1survived_scene()

func _on_timer_12_timeout() -> void: 
	ProgressionManager.timer_ran_out()
