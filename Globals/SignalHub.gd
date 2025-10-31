extends Node

signal item_collected(item: InvItem)
signal on_newspaper_pickup
signal item_description(item: InvItem)
signal open_inventory_for_placement(area: InteractableArea)
signal show_interaction_prompt(text: String)
signal hide_interaction_prompt

func emit_item_collected(collected_item: InvItem) -> void: 
	item_collected.emit(collected_item)

func emit_newspaper_pickup() -> void: 
	on_newspaper_pickup.emit()

func emit_item_description(item: InvItem) -> void: 
	item_description.emit(item)

func emit_open_inventory_for_placement(area: InteractableArea) -> void: 
	open_inventory_for_placement.emit(area)

func emit_show_interaction_prompt(text: String) -> void: 
	show_interaction_prompt.emit()

func emit_hide_interaction_prompt() -> void: 
	hide_interaction_prompt.emit()
