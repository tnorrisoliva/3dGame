extends StaticBody3D

@export var key_name: String = "gold_key"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func pickup(player) -> void:
	print("picked up",key_name)
	player.inventory.append(key_name)
	$"..".hide()
	queue_free()
