extends StaticBody3D

@export var required_pin: String = "1654"
@export var hover_label:  String = "E to interact"
var is_open = false

var waiting_for_pin = false

var player_ref: Node = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Door ready:", self.name)

	if Dialogic == null:
		push_error("Dialogic not loaded — check AutoLoad!")
		return
		
		#connects signal to dialogic
	if not Dialogic.timeline_ended.is_connected(_on_dialogic_timeline_ended):
		Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)
		print("Connected timeline_ended signal to door:", self.name)
		
	else:
		print("Signal already connected for:", self.name)

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
	
	var ConvEntered_pin = str(entered_pin)
	
	print(required_pin)
	if typeof(required_pin) == TYPE_STRING:
		print(" r is String")
	print(ConvEntered_pin)
	if typeof(ConvEntered_pin) ==TYPE_STRING:
		print("c is string")	
	if ConvEntered_pin == required_pin:
		open_door()
		print("it works")	
		if player_ref:
			player_ref.hud.show_message("Door Unlocked!", 1.0)
			print("PIN correct, opening door!")
	else:
		if player_ref:
			player_ref.hud.show_message("Incorrect PIN!", 1.0)
			print("it doesn't")

	
	
func _on_dialogic_timeline_ended(timeline_name):
	print("Timeline ended:", timeline_name)
	
	if timeline_name != "doorLock":
		return  # only run for this specific timeline
	waiting_for_pin = false
	
	var entered_pin = Dialogic.VAR.Painting
	
	if entered_pin == required_pin:
		open_door()
		print("it works")	
		if player_ref:
			player_ref.hud.show_message("Door Unlocked!", 1.0)
			print("PIN correct, opening door!")
	else:
		if player_ref:
			player_ref.hud.show_message("Incorrect PIN!", 1.0)
			print("it doesn't")

func open_door():
	is_open = true
	queue_free()
	$"..".hide()
	print("door opened")
func door_hover(player):
	player.hud.show_hover_message(hover_label)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
