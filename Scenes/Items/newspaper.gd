extends Node2D

@export var item: InvItem
var player = null

func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body is Player:
		SignalHub.emit_item_collected(item)
		SignalHub.emit_newspaper_pickup()
		await get_tree().create_timer(0.1).timeout
		self.queue_free()
