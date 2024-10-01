extends CanvasLayer

# Function to handle the start button press
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")  # Change to the new scene

# Function to handle the quit button press
func _on_quit_pressed() -> void:
	get_tree().quit()  # Quit the game

# Ready function to connect signals
func _ready() -> void:
	$Start.connect("pressed", Callable(self, "_on_start_pressed"))
	$Quit.connect("pressed", Callable(self, "_on_quit_pressed"))
