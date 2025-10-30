extends Node

const NEWSPAPER = preload("res://Scenes/Description Cards/newspaper_description.tscn")

func load_NEWSPAPER() -> void: 
	get_tree().change_scene_to_packed(NEWSPAPER)
