extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const JUMP2_VELOCITY = -500.0
var JUMP_MAX = 2
var JUMP_MAKE = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		JUMP_MAKE = 0
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		JUMP_MAKE += 1
	else:
		if Input.is_action_just_pressed("ui_accept") and JUMP_MAKE < JUMP_MAX:
			velocity.y = JUMP2_VELOCITY
			JUMP_MAKE += 1
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
