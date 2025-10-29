extends CanvasLayer



@onready var message_label: Label = $Label
@onready var inventory_label: Label = $"player inventory"
@onready var hover_label: Label = $"hover label"



var message_timer := 0.0
var message_duration := 0.2

var fade_speed = 2.0

func _ready():
	message_label.text = ""
	message_label.visible = false
	hover_label.visible = false
	hover_label.text = ""

func show_message(text: String, duration := 2.0):
	message_label.text = text
	message_label.visible = true
	message_timer = 0.0
	message_duration = duration
	
func show_hover_message(text: String):
	hover_label.visible = true
	hover_label.text = text
func hide_hover_message():
	hover_label.visible = false
	hover_label.text = ""
		

func update_inventory(items: Array ):
	if items.is_empty():
		inventory_label.text= "Inventory: (empty)"
	else: 
		inventory_label.text = " Inventory:  " + ", ". join(items)

func _process(delta):
	if message_label.visible:
		message_timer += delta
		if message_timer > message_duration:
			#fade out on messages
			var new_alpha = lerp(1.0, 0.0, (message_timer - message_duration)* fade_speed)
			message_label.modulate.a = new_alpha
			if new_alpha <= 0.01 :
				message_label.modulate.a = 1.0
				message_label.visible = false
				
			
