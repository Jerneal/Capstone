extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Access the autoloaded player node
	var player = get_node("/root/Player")

	if player:
		print("Player found!")
		
		# Set the player's position to its last known position
		player.position = player.last_position  # Use the stored last position

		# Ensure the player is visible
		player.visible = true
		
		# Add player to the current node to ensure it renders
		if not player.is_inside_tree():
			add_child(player)
		
		# Adjust Z-index to ensure the player appears in front of other objects
		player.z_index = 1  # Ensure it's higher than other nodes
	else:
		print("Player not found!")

# Check if the player is near the screen edge and trigger scene change
func check_screen_edge():
	# Access the autoloaded player node
	var player = get_node("/root/Player")
	
	if player:
		var screen_rect = get_viewport_rect()
		var sprite = player.get_node("Sprite2D")  # Replace with the actual name of your sprite node
		var sprite_width = sprite.texture.get_size().x * sprite.scale.x  # Get width of the sprite

		# Left edge: if player is near the left screen edge
		if player.position.x <= sprite_width / 2 and player.velocity.x < 0:
			change_scene("res://world.tscn")  # Trigger scene change when moving left
		
		# Right edge: if player is near the right screen edge
		elif player.position.x >= screen_rect.size.x - sprite_width / 2 and player.velocity.x > 0:
			change_scene("res://scene2.tscn")  # Trigger scene change when moving right

# Function to handle scene changes
func change_scene(scene_path: String):
	# Optional: Fade out or show some effect before changing the scene
	get_tree().change_scene_to_file(scene_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_screen_edge()  # Check for scene transition every frame
