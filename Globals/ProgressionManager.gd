extends Node

# REMINDER!! 
# If you need to update which night scene is being loaded in at any given 
# time YOU HAVE IT STORED HERE!!!! 
# (Specifically the "load_ritual_night / load_normal_night" sections)

#signal ritual_complete
#signal player_caught
#signal timer_expired
#signal night_progression(condition: String) 

var ritual_items_collected: int = 0 
var ritual_items_needed: int = 2 
var current_night: int = 1
var is_ritual_version: bool = false

var items_placed_correctly: int = 0 
var items_needed_for_ending: int = 6
var items_at_night_end: int = 0

var night_ended: bool = false

#@export var slots: Array[InvSlot]
#var slot_index: int = 0
#signal update

func _ready() -> void:
	SignalHub.item_collected.connect(_on_item_collected)


func count_ritual_items_in_inventory() -> int: 
	if not InventoryManager.inventory:
	#var player = get_tree().get_first_node_in_group("Player")
	#if player == null: 
		print("ERROR: InventoryManager not initialized")
		return 0
		
	var count = 0 
	for slot in InventoryManager.inventory.slots:
		if slot != null and slot.item != null and slot.item.is_ritual_item:
			count += slot.amount
	
	print("Ritual Items in inventory: ", count)
	return count


func item_placed_in_area():
	items_placed_correctly += 1 
	print("Items placed: ", items_placed_correctly, "/", items_needed_for_ending)
	
	if items_placed_correctly >= items_needed_for_ending:
		trigger_final_ending()


func trigger_final_ending():
	print("All items placed! Triggering ending...")
	get_tree().change_scene_to_file("res://Scenes/EndCards/ritual_ending.tscn")



func _on_item_collected(item: InvItem) -> void: 
	if item.is_ritual_item:
		ritual_items_collected += 1
		print("Ritual items: ", ritual_items_collected, "/", ritual_items_needed)
	
		if ritual_items_collected >= ritual_items_needed:
			complete_ritual()



func complete_ritual() -> void: 
	if night_ended:
		return
	night_ended = true
	
	print("All ritual items collected! Progressing to next night...")
	
	await  get_tree().process_frame
	
	items_at_night_end = count_ritual_items_in_inventory()
	print("Ritual complete with ", items_at_night_end, " items (total in inventory)")
	SignalHub.emit_ritual_complete()
	
	#night_progression.emit("ritual")
	#show_items_screen()
	#
	#load_ritual_night(current_night + 1)
# moving these two lines down, so that there is not a tree pause attempt while 
# there is also a scene transition being called


func player_was_caught() -> void:
	if night_ended:
		return
	night_ended = true 
	
	print("Player was caught!")
	
	items_at_night_end = count_ritual_items_in_inventory()
	print("Player caught with ", items_at_night_end, " items")
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
	if night_ended:
		return
	night_ended = true 
	
	print("Timer expired - player survived!")
	
	items_at_night_end = count_ritual_items_in_inventory()
	print("Player survived with ", items_at_night_end, " items")
	show_survived_screen()
	
	#if is_ritual_version:
		#load_ritual_night(current_night + 1)
	#else: 
		#load_normal_night(current_night + 1)
# including this will override the caught card, so commenting out for now



func show_ritual_complete_screen():
	print("Showing ritual complete card for night ", current_night)
	var item_count = items_at_night_end
	match current_night:
		1:
			match item_count:
				2:
					GameManager.load_night1itemsfound_scene()
		2:
			match item_count:
				4:
					GameManager.load_night2itemsfound_scene()
		3: 
			match item_count:
				0:
					GameManager.load_good_scene()
				1: 
					GameManager.load_neuteral_scene()
				2:
					GameManager.load_mid_scene()
				3: 
					GameManager.load_notgreat_scene()
				4:
					GameManager.load_bad_scene()
				5:
					GameManager.load_worst_scene() 
				6:
					GameManager.load_night3itemsfound_scene()



func show_caught_screen():
	var item_count = items_at_night_end
	match current_night: 
		1:
			match item_count: 
				0, 1:
					GameManager.load_night1caught_scene()
		2:
			match item_count: 
				0, 1, 2, 3:
					GameManager.load_night2caught_scene()
		3: 
			match item_count:
				0:
					GameManager.load_good_scene()
				1: 
					GameManager.load_neuteral_scene()
				2:
					GameManager.load_mid_scene()
				3: 
					GameManager.load_notgreat_scene()
				4:
					GameManager.load_bad_scene()
				5:
					GameManager.load_worst_scene()


func show_survived_screen():
	var item_count = items_at_night_end
	match current_night:
		1: 
			match item_count:
				0, 1: 
					GameManager.load_night1survived_scene()
		2:
			match item_count:
				0, 1, 2, 3:
					GameManager.load_night2survived_scene()
		3: 
			match item_count:
				0:
					GameManager.load_good_scene()
				1: 
					GameManager.load_neuteral_scene()
				2:
					GameManager.load_mid_scene()
				3: 
					GameManager.load_notgreat_scene()
				4:
					GameManager.load_bad_scene()
				5:
					GameManager.load_worst_scene()


func continue_to_ritual_night():
	print("Continuing to ritual night ", current_night + 1)
	load_ritual_night(current_night + 1, items_at_night_end)


func continue_to_next_night():
	print("Continuing to next night. Current: ", current_night, " Ritual version: ", is_ritual_version)
	
	#if is_ritual_version:
		#load_ritual_night(current_night + 1)
	#else: 
	load_normal_night(current_night + 1, items_at_night_end)


func load_normal_night(night_num: int, item_count: int = 0):
	current_night = night_num
	#is_ritual_version = false 
	reset_for_new_night()
	
	match night_num:
		1:
			get_tree().change_scene_to_file("res://Scenes/Night1/night_1_test.tscn")
		2:
			match item_count:
				0:
					get_tree().change_scene_to_file("res://Scenes/Night2/ItemNights/night_2_0_items.tscn")
				1:
					get_tree().change_scene_to_file("res://Scenes/Night2/ItemNights/night_2_1_item.tscn")
		3:
			match item_count:
				0:
					get_tree().change_scene_to_file("res://Scenes/Night3/ItemNights/night_3_0_items.tscn")
				1: 
					get_tree().change_scene_to_file("res://Scenes/Night3/ItemNights/night_3_1_item.tscn")
				2:
					get_tree().change_scene_to_file("res://Scenes/Night3/ItemNights/night_3_2_items.tscn")
				3:
					get_tree().change_scene_to_file("res://Scenes/Night3/ItemNights/night_3_3_items.tscn")



func load_ritual_night(night_num: int, _item_count: int = 0):
	current_night = night_num
	#is_ritual_version = true
	reset_for_new_night()
	
	match night_num:
		1:
			get_tree().change_scene_to_file("res://Scenes/Night2/ritual_night_2.tscn")
		2:
			get_tree().change_scene_to_file("res://Scenes/Night2/ritual_night_2.tscn")
		3:
			get_tree().change_scene_to_file("res://Scenes/Night3/ritual_night_3.tscn")
		4:
			get_tree().change_scene_to_file("res://Scenes/Night4/ritual_night_4.tscn")



func reset_for_new_night() -> void: 
	ritual_items_collected = 0
	night_ended = false



func start_new_game():
	#is_ritual_version = false
	current_night = 1
	ritual_items_collected = 0
	ritual_items_needed = 2
	items_placed_correctly = 0
	items_at_night_end = 0
	night_ended = false
	
	InventoryManager.clear_inventory()
	GameManager.load_newgame_scene()


#func reset_inventory(slots: int):
	#if slot_index >= 0 and slot_index < slots.amount():
		#if slots[slot_index].amount > 1: 
			#slots[slot_index].amount -= 1
		#else:
			#slots[slot_index].item = null
			#slots[slot_index].amount = 0 
		#update.emit()
