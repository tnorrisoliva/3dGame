extends CharacterBody3D


const SPEED = 4.0
const JUMP_VELOCITY = 4.5
@onready var neck :=$neck
@onready var camera :=$neck/Camera3D
@onready var hud = $HUD

@export var inventory = [] # store collected keys

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		#locks mouse
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		#unlocks mouse
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x *0.01)
			camera.rotate_x(-event.relative.y *0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if $neck/Camera3D/RayCast3D.is_colliding():
		var target = $neck/Camera3D/RayCast3D.get_collider()
		print(target)
		if target and target.has_method("pickup"):
			if Input.is_action_just_pressed('interact'):
				target.pickup(self)
				print (inventory)
		elif target and target.has_method("interact") and Input.is_action_just_pressed('interact'):
			target.interact(self)#refecnces interact methof not input

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_foward", "move_back")
	#added .neck it computes directio nased on rotation of neck node rather than the orginal position of the player
	var direction = (neck.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
