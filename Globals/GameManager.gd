extends Node

#const NEWSPAPER = preload("res://Scenes/Description Cards/newspaper_description.tscn")
#
#func load_NEWSPAPER() -> void: 
	#get_tree().change_scene_to_packed(NEWSPAPER)

const NIGHT1CAUGHT = preload("res://Scenes/Night1/night_1_caught.tscn")
const NIGHT1SURVIVED = preload("res://Scenes/Night1/night_1_survived.tscn")

const NIGHT2CAUGHT = preload("res://Scenes/Night2/night_2_caught.tscn")
const NIGHT2SURVIVED = preload("res://Scenes/Night2/night_2_survived.tscn")

const ENDCAUGHT = preload("res://Scenes/EndCards/end_caught.tscn")
const ENDSURVIVED = preload("res://Scenes/EndCards/end_survived.tscn")
const BADEND = preload ("res://Scenes/EndCards/true_ending_bad.tscn")
const GOODEND = preload("res://Scenes/EndCards/true_ending_good.tscn")

const NIGHT1ITEMSFOUND = preload("res://Scenes/Night1/items_collected_night_1.tscn")
const NIGHT2ITEMSFOUND = preload("res://Scenes/Night2/items_collected_night_2.tscn")
const NIGHT3ITEMSFOUND = preload("res://Scenes/Night3/items_collected_night_3.tscn")

const NIGHT2C_S = preload("res://Scenes/Night2/night_2_c_s.tscn")
const NIGHT3C_S = preload("res://Scenes/Night3/night_3_c_s.tscn")


func load_night1caught_scene() -> void: 
	get_tree().change_scene_to_packed(NIGHT1CAUGHT)

func load_night1survived_scene() -> void: 
	get_tree().change_scene_to_packed(NIGHT1SURVIVED)



func load_night2caught_scene() -> void: 
	get_tree().change_scene_to_packed(NIGHT2CAUGHT)

func load_night2survived_scene() -> void: 
	get_tree().change_scene_to_packed(NIGHT2SURVIVED)



func load_endcaught_scene() -> void: 
	get_tree().change_scene_to_packed(ENDCAUGHT)

func load_endsurvived_scene() -> void: 
	get_tree().change_scene_to_packed(ENDSURVIVED)

func load_badend_scene() -> void: 
	get_tree().change_scene_to_packed(BADEND)

func load_goodend_scene() -> void: 
	get_tree().change_scene_to_packed(GOODEND)



func load_night1itemsfound_scene() -> void:
	get_tree().change_scene_to_packed(NIGHT1ITEMSFOUND)

func load_night2itemsfound_scene() -> void: 
	get_tree().change_scene_to_packed(NIGHT2ITEMSFOUND)

func load_night3itemsfound_scene() -> void: 
	get_tree().change_scene_to_packed(NIGHT3ITEMSFOUND)



func load_night2c_s_scene() -> void: 
	get_tree().change_scene_to_packed(NIGHT2C_S)
