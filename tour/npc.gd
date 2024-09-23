extends CharacterBody2D  # Use Area2D if NPC doesn't need physics

# Dialog data for the NPC
var dialog = [
	"Hello traveler!",
	"I can give you tips on your journey.",
	"Good luck out there!"
]
var dialog_index = 0
var player_in_range = false  # Tracks if the player is in interaction range

@onready var rich_text_label = $DialogBox/RichTextLabel  # Reference to the RichTextLabel in the NPC dialog box

# Function to load and show the dialog
func load_dialog():
	if dialog_index < dialog.size():
		rich_text_label.bbcode_text = dialog[dialog_index]
		dialog_index += 1
	else:
		# Hide dialog when finished
		$DialogBox.hide()

# Function to reset the dialog when the player interacts
func reset_dialog():
	dialog_index = 0
	$DialogBox.show()
	load_dialog()

# Detect when the player enters interaction zone (Area2D)
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):  # Check if the body entering is the player
		player_in_range = true
		print("Player entered interaction zone")  # Debug message

# Detect when the player exits the interaction zone (Area2D)
func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):  # Check if the body exiting is the player
		player_in_range = false
		print("Player left interaction zone")  # Debug message

# Process input to interact with the NPC if the player is close
func _process(delta):
	if player_in_range and Input.is_action_just_pressed("ui_accept"):  # "ui_accept" can be Enter or other key
		load_dialog()


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
