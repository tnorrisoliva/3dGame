extends StaticBody3D

@export var hover_label:  String = "E to talk"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func door_hover(player):
	player.hud.show_hover_message(hover_label)
	
func interact(player):
	# attempt to allow the e key to continue conversations 
	var count = 1
	if count == 1: 
		
		DialogicStart()
		count += 1
		print(count)
	if count == 2:
		print(count)
		count-= 1
		
		return
		
	
		
		
		
	
	
	
func DialogicStart():
	Dialogic.start("frontDesk")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
