extends Node2D

# You have archived this scene due to some weirdness happening with 
# the get_tree pause / item description card overlays. You created a NEW scene
#for the ritual nights, that does not inherit from the base test world scene 
#to try and fix this issue

func _ready():
	print("Ritual night loaded")
	print("NewspaperDescription exists: ", has_node("NewspaperDescription"))
	print("RitualItem2Description exists: ", has_node("RitualItem2Description"))
	# Check if they're in the tree
	var newspaper_desc = get_node_or_null("NewspaperDescription")
	if newspaper_desc:
		print("Newspaper tree: ", newspaper_desc.get_tree())
