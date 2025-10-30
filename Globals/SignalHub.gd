extends Node

signal item_collected(item: InvItem)
signal on_newspaper_pickup

func emit_item_collected(collected_item: InvItem) -> void: 
	item_collected.emit(collected_item)

func emit_newspaper_pickup() -> void: 
	on_newspaper_pickup.emit()
