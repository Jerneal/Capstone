extends CharacterBody2D

var speed = 200  # Movement speed
@onready var animations = $AnimationPlayer  # Reference to AnimationPlayer

# Handle both keyboard and touchscreen input for movement
func handleInput():
	var moveDirection = 0

	# Handle touchscreen buttons
	if Input.get_action_strength("move_left"):
		moveDirection -= 1
	if Input.get_action_strength("move_right"):
		moveDirection += 1

	# Keyboard movement (optional, for compatibility)
	moveDirection += Input.get_axis("Left", "Right")

	# Apply movement to velocity.x
	velocity.x = moveDirection * speed

# Update animations based on movement
func updateAnimation():
	if velocity.length() == 0:
		animations.stop()
	elif velocity.x < 0:  # Moving left
		animations.play("Run")
	elif velocity.x > 0:  # Moving right
		animations.play("Run")

# Physics process for movement and animation
func _physics_process(_delta):
	handleInput()  # Handle movement input
	move_and_slide()  # Apply movement to the character
	updateAnimation()  # Update the animation based on the movement
