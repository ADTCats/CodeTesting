extends Node

signal player_caught
signal ritual_complete

signal night_01_complete(won: bool)
signal night_02_complete(won: bool)
signal night_03_complete(won: bool)

signal item_collected(item: InvItem)

signal open_inventory_for_placement(area: InteractableArea)
signal show_interaction_prompt(text: String)
signal hide_interaction_prompt

signal on_newspaper_pickup
signal newspaper_description(item: InvItem)

signal on_ritualitem2_pickup
signal ritualitem2_description(item: InvItem)

signal on_ritualitem3_pickup
signal ritualitem3_description(item: InvItem)

signal on_ritualitem4_pickup 
signal ritualitem4_description(item: InvItem)

signal on_ritualitem5_pickup
signal ritualitem5_description(item: InvItem)

signal on_ritualitem6_pickup
signal ritualitem6_description(item: InvItem)



func emit_player_caught() -> void: 
	player_caught.emit()

func emit_ritual_complete() -> void: 
	ritual_complete.emit()


func emit_night_01_complete() -> void: 
	night_01_complete.emit()

func emit_night_02_complete() -> void: 
	night_02_complete.emit()

func emit_night_03_complete() -> void: 
	night_03_complete.emit()



func emit_item_collected(collected_item: InvItem) -> void: 
	item_collected.emit(collected_item)


func emit_newspaper_pickup() -> void: 
	on_newspaper_pickup.emit()

func emit_newspaper_description(item: InvItem) -> void: 
	newspaper_description.emit(item)


func emit_ritualitem2_pickup() -> void: 
	on_ritualitem2_pickup.emit()

func emit_ritualitem2_description(item: InvItem) -> void: 
	ritualitem2_description.emit(item)


func emit_ritualitem3_pickup() -> void: 
	on_ritualitem3_pickup.emit()

func emit_ritualitem3_description(item: InvItem) -> void: 
	ritualitem3_description.emit(item)


func emit_ritualitem4_pickup() -> void: 
	on_ritualitem4_pickup.emit()

func emit_ritualitem4_description(item: InvItem) -> void: 
	ritualitem4_description.emit(item)


func emit_ritualitem5_pickup() -> void: 
	on_ritualitem5_pickup.emit()

func emit_ritualitem5_description(item: InvItem) -> void: 
	ritualitem5_description.emit(item)


func emit_ritualitem6_pickup() -> void: 
	on_ritualitem6_pickup.emit()

func emit_ritualitem6_description(item: InvItem) -> void: 
	ritualitem6_description.emit(item)


func emit_open_inventory_for_placement(area: InteractableArea) -> void: 
	open_inventory_for_placement.emit(area)

func emit_show_interaction_prompt(_text: String) -> void: 
	show_interaction_prompt.emit()

func emit_hide_interaction_prompt() -> void: 
	hide_interaction_prompt.emit()
