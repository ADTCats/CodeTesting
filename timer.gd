extends Control

class_name TimerUIBase

@onready var pm_10: Label = $MC/pm10
@onready var pm_11: Label = $MC/pm11
@onready var am_12: Label = $MC/am12

@onready var timer_10: Timer = $Timer10
@onready var timer_11: Timer = $Timer11
@onready var timer_12: Timer = $Timer12

func _ready() -> void:
	pm_11.hide()
	am_12.hide()
	pm_10.show()
	timer_10.start()

func _on_timer_10_timeout() -> void: 
	pm_10.hide()
	pm_11.show()
	timer_11.start()

func _on_timer_11_timeout() -> void: 
	pm_11.hide()
	am_12.show()
	timer_12.start()

func _on_timer_12_timeout() -> void: 
	pass
