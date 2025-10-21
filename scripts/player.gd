extends CharacterBody3D

## The movement speed in m/s. Default is 5.
@export_range(1.0,30.0) var speed : float = 5.0
## The Jump Velocity in m/s- default to 6.0
@export_range(2.0,10.0) var jump_velocity : float = 7.0

## Mouse sensitivity for looking around. Default is 3.0
@export_range(1.0,5.0) var mouse_sensitivity = 2.0
var mouse_motion : Vector2 = Vector2.ZERO
var pitch = 0

## The amount of acceleration on the ground- less feels floaty, more is snappy-[br]Default is 4
@export_range(1.0,10.0) var ground_acceleration := 3.5
## the amount of acceleration when in the air. less feels more floaty more is more snappy.[br]Default is 0.5
@export_range(0.0,5.0) var air_acceleration := 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export_range(5.0,25.0) var gravity : float = 15.0

# the camera pivot for head pitch movement
@onready var camera_pivot : Node3D = $CameraPivot

#Where the player respawns everytime they die
var StartPosition = Vector3(0,10,0)
var doublejump = 0


#variables

#functions 


	
	
func jump():
	velocity.y = jump_velocity


func respawn():
	position = StartPosition
	velocity.x = 0
	velocity.z = 0
	velocity.y = 0

func NEW(new_respawn):
	StartPosition = Vector3(new_respawn.x,new_respawn.y + 5, new_respawn.z)
	print(new_respawn.y)


func _physics_process(delta):

	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	#If the player falls below a certain ranges, they will be respawned
	if position.y < -15:
		respawn()
	
	# Handle Jump and double jump.

	if is_on_floor() or is_on_wall():
		ground_acceleration = 3.5
		air_acceleration = 0.1
		doublejump = 0
		if Input.is_action_just_pressed("ui_accept"):
			jump()
			
	else:
		if doublejump == 0:
			if Input.is_action_just_pressed("ui_accept"):
				
				doublejump = 1 
				jump()
				
			
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	var target_velocity := Vector3.ZERO
	var Speed = 0.7*speed
	if direction:
		target_velocity = direction
	
	#now apply velocity with lerp based on whether on ground or in air
	if is_on_floor():
		velocity.x = move_toward(velocity.x , target_velocity.x * speed , speed * ground_acceleration * delta)
		velocity.z = move_toward(velocity.z, target_velocity.z * speed, speed * ground_acceleration * delta)
	else:
		if doublejump == 0:
			velocity.x = move_toward(velocity.x , target_velocity.x * speed , speed * air_acceleration * delta)
			velocity.z = move_toward(velocity.z, target_velocity.z * speed, speed * air_acceleration * delta)
		elif doublejump == 1:
			velocity.x = target_velocity.x * Speed
			velocity.z = target_velocity.z * Speed

		
	#now actually move based on velocity
	move_and_slide()
	
	#rotate the player and camera pivot based on mouse movement
	rotate_y(-mouse_motion.x * mouse_sensitivity / 1000)
	pitch -= mouse_motion.y * mouse_sensitivity / 1000
	pitch = clampf(pitch,-1.35,1.35)
	camera_pivot.rotation.x = pitch
	#reset it
	mouse_motion = Vector2.ZERO
	
	
#handle and store mouse motion

	
func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		mouse_motion = event.relative
		
