extends Node

var ritual_items_collected: int = 0 
var ritual_items_needed: int = 2 
var current_night: int = 1
var is_ritual_version: bool = false

#signal ritual_complete
#signal player_caught
#signal timer_expired
#signal night_progression(condition: String) 

func _ready() -> void:
	SignalHub.item_collected.connect(_on_item_collected)



func _on_item_collected(item: InvItem) -> void: 
	if item.is_ritual_item:
		ritual_items_collected += 1
		print("Ritual items: ", ritual_items_collected, "/", ritual_items_needed)
	
		if ritual_items_collected >= ritual_items_needed:
			complete_ritual()



func complete_ritual() -> void: 
	print("All ritual items collected! Progressing to next night...")
	SignalHub.emit_ritual_complete()
	#night_progression.emit("ritual")
	#show_items_screen()
	#
	#load_ritual_night(current_night + 1)
# moving these two lines down, so that there is not a tree pause attempt while 
# there is also a scene transition being called


func player_was_caught() -> void:
	print("Player was caught!")
	show_caught_screen()
	
	#SignalHub.emit_player_caught()
#This line was causing an infinite recursion, removing it to clean that up
	#night_progression.emit("caught")
	
	#if is_ritual_version:
		#load_ritual_night(current_night + 1)
	#else: 
		#load_normal_night(current_night + 1)
# including this will override the caught card, so commenting out for now


func timer_ran_out() -> void: 
	print("Timer expired - player survived!")
	show_survived_screen()
	
	#if is_ritual_version:
		#load_ritual_night(current_night + 1)
	#else: 
		#load_normal_night(current_night + 1)
# including this will override the caught card, so commenting out for now



func show_ritual_complete_screen():
	print("Showing ritual complete card for night ", current_night)
	
	match current_night:
		1:
			GameManager.load_night1itemsfound_scene()
		#2:
			#GameManager. lbjalbjakbj 
		#3: 
			#GameManager. ljaf;lejaofp;eia 
		#4: 
			#GameManager. claj;oiejafp;eij 
			#load_ritual_night(current_night + 1)



func show_caught_screen():
	match current_night: 
		1:
			GameManager.load_night1caught_scene()
		2:
			GameManager.load_night2caught_scene()


func show_survived_screen():
	match current_night:
		1: 
			GameManager.load_night1survived_scene()
		2:
			GameManager.load_night2survived_scene()


#func show_items_screen():
	#match current_night:
		#1:
			#GameManager.load_night1itemsfound_scene()


func continue_to_ritual_night():
	print("Continuing to ritual night ", current_night + 1)
	load_ritual_night(current_night + 1)



func continue_to_next_night():
	print("Continuing to next night. Current: ", current_night, " Ritual version: ", is_ritual_version)
	
	#if is_ritual_version:
		#load_ritual_night(current_night + 1)
	#else: 
	load_normal_night(current_night + 1)




func load_normal_night(night_num: int):
	current_night = night_num
	is_ritual_version = false 
	reset_for_new_night()
	
	match night_num:
		1:
			get_tree().change_scene_to_file("res://Scenes/Night1/night_1_test.tscn")
		2:
			get_tree().change_scene_to_file("res://Scenes/Night2/night_2_c_s.tscn")
		#3:
			#get_tree().change_scene_to_file("res://Scenes/Levels/night_03.tscn")
		#4:
			#get_tree().change_scene_to_file("res://Scenes/Levels/night_04.tscn")
		#_:
			#print("Game complete!")
# commenting this section out for now - need to get those built before I can hook them up


func load_ritual_night(night_num: int):
	current_night = night_num
	is_ritual_version = true
	reset_for_new_night()
	
	match night_num:
		1:
			get_tree().change_scene_to_file("res://Scenes/Night2/night_2_ritual.tscn")
		2:
			get_tree().change_scene_to_file("res://Scenes/Night2/night_2_ritual.tscn")
		#3:
			#get_tree().change_scene_to_file("res://Scenes/Levels/ritual_night_03.tscn")
		#4:
			#get_tree().change_scene_to_file("res://Scenes/Levels/ritual_night_04.tscn")
		#_:
			#print("Ritual path complete!")
# commenting this section out for now - need to get those built before I can hook them up



func reset_for_new_night() -> void: 
	ritual_items_collected = 0

func start_new_game():
	current_night = 1
	is_ritual_version = false
	load_normal_night(1)
