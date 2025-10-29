extends StaticBody3D

@export var required_key: String = "gold_key"
@export var hover_label:  String = "E to interact"
var is_open = false

func door_hover(player):
	# shows Hud label if hovering
	player.hud.show_hover_message(hover_label)
	


func interact(player):
	if is_open:
		return
	if required_key in player.inventory:
		print("door unlocked with", required_key)
		player.hud.show_message("door unlocked with gold key",1.0)
		
		player.inventory.erase(required_key)
		player.hud.update_inventory(player.inventory)
		
		open_door()
	else:
		print("you need the", required_key)
		player.hud.show_message("you need the gold key", 1.0)
func open_door():
	is_open = true
	queue_free()
	$"..".hide() # might delete depends on feedback
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
