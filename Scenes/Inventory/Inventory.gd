extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem): 
	_ensure_slots_initalized()
	#for i in range(min(5, slots.size())):
		#var slot = slots[i]
	#
	var itemslots = slots.filter(func(slot): return slot != null and slot.item == item)
	
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else: 
		var emptyslots = slots.filter(func(slot): return slot != null and slot.item == null)
		
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()

func _ensure_slots_initalized():
	if slots.is_empty() or slots [0] == null: 
		slots.clear()
		for i in range(18):
			var slot = InvSlot.new()
			slots.append(slot)

func remove_item(slot_index: int):
	if slot_index >= 0 and slot_index < slots.size():
		if slots[slot_index].amount > 1: 
			slots[slot_index].amount -= 1
		else:
			slots[slot_index].item = null
			slots[slot_index].amount = 0 
		update.emit()
