extends Node

# Variables to persist across scenes
var player_position: Vector2 = Vector2(10,8)

# Function to save the player's position
func save_position(pos: Vector2):
	player_position = pos

# Function to load the player's position
func load_position() -> Vector2:
	return player_position
