extends CharacterBody2D

var speed = 200
@onready var animations = $AnimationPlayer  # Ensure this path points to your AnimationPlayer node
@onready var sprite = $Sprite2D  # Ensure this path points to your Sprite2D node

var scene_change_zone_size = 1  # Customizable size of the scene change area
var last_position: Vector2

# Handle both keyboard and touchscreen input for movement
func handleInput():
	var moveDirection = 0
	if Input.get_action_strength("move_left"):
		moveDirection -= 1
	if Input.get_action_strength("move_right"):
		moveDirection += 1
	moveDirection += Input.get_axis("Left", "Right")
	velocity.x = moveDirection * speed

# Update animations and sprite direction based on movement
func updateAnimation():
	# Ensure that the AnimationPlayer node is properly assigned
	if animations == null:
		print("AnimationPlayer not found!")  # Debug message for missing AnimationPlayer
		return  # Prevent further execution if animations is null

	# Check if the player is idle (no horizontal movement)
	if velocity.x == 0:
		if animations.current_animation != "Idle":
			animations.play("Idle")
	elif velocity.x < 0:  # Moving left
		if animations.current_animation != "Run":
			animations.play("Run")
		sprite.flip_h = true  # In Godot 4, use flip_h to flip horizontally
	elif velocity.x > 0:  # Moving right
		if animations.current_animation != "Run":
			animations.play("Run")
		sprite.flip_h = false  # Ensure sprite is not flipped
# Called when the scene is ready
func _ready():
	# Load player position when the scene starts
	position = PlayerData.load_position()
	last_position = position
	

func update_last_position():
	last_position = position  # Update the last position whenever the player moves

# Call this function before changing scenes
func save_position():
	last_position = position

# Add this in your movement logic, if applicable
func _process(delta):
	# Update position and handle movement
	update_last_position()



# Physics process for movement and animation
func _physics_process(_delta):
	handleInput()
	move_and_slide()
	updateAnimation()
