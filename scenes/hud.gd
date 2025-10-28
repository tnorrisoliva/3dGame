extends CanvasLayer



@onready var message_label: Label = $Label
var message_timer := 0.0
var message_duration := 0.2
func _ready():
	message_label.text = ""
	message_label.visible = false

func show_message(text: String, duration := 2.0):
	message_label.text = text
	message_label.visible = true
	message_timer = 0.0
	message_duration = duration

func _process(delta):
	if message_label.visible:
		message_timer += delta
		if message_timer > message_duration:
			message_label.visible = false
