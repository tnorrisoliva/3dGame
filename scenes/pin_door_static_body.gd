extends StaticBody3D

@export var required_pin: String = "1654"
var is_open = false

var waiting_for_pin = false

var player_ref: Node = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		if not Dialogic.timeline_ended.is_connected(_on_dialogic_timeline_ended):
			Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)
func interact(player):
	
	
	if is_open:
		return
	if not waiting_for_pin:
		Dialogic.start("doorLock")
		waiting_for_pin = true
		#saves a reference to player in order to show hud messages later
		self.player_ref = player
		return
	var entered_pin = Dialogic.VAR.Painting

	
	
func _on_dialogic_timeline_ended(timeline_name):
	if timeline_name != "doorLock":
		return  # only run for this specific timeline
	waiting_for_pin = false
	
	var entered_pin = Dialogic.VAR.Painting
	
	if entered_pin == required_pin:
		open_door()
		if player_ref:
			player_ref.hud.show_message("Door Unlocked!", 1.0)
	else:
		if player_ref:
			player_ref.hud.show_message("Incorrect PIN!", 1.0)

func open_door():
	is_open = true
	queue_free()
	$"..".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
