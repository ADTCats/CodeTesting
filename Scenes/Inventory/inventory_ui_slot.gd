extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay

func update(slot: InvSlot): 
	if slot == null:
		item_visual.visible = false
		return
	
	if !slot.item: 
		item_visual.visible = false 
	else:
		item_visual.visible = true 
		item_visual.texture = slot.item.texture
