extends Resource

class_name InvItem

@export var name: String = ""
@export var texture: Texture2D
@export_multiline var description: String = ""
# This call makes the "description" field show up in the Inspector 
# as a multi-line text box instead of a single-line input.
@export var is_ritual_item: bool = false
