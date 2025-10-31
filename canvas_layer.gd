extends CanvasLayer

@onready var name_input = $LineEdit
@onready var status = $Status
@onready var continue_button = $Button

func _ready():
	continue_button.pressed.connect(_on_continue_pressed)
	if (GameManager.won):
		status.text = "Congrats, You survived"

func _on_continue_pressed():
	var player_name = name_input.text.strip_edges()
	if player_name.is_empty():
		print("Please enter a name.")
		return

	# Store the name in a global variable (singleton)
	GameManager.solver_group_id = player_name

	# Change to the main scene
	# Change label to hashed / hardcoded code
	status.text = "Your code: xxx1"
	
	# Remove other nodes
	if is_instance_valid(name_input):
		name_input.queue_free()
	if is_instance_valid(continue_button):
		continue_button.queue_free()
	
	# Optional: center or resize status text
	status.add_theme_color_override("font_color", Color(1, 1, 0)) # gold text
	status.add_theme_font_size_override("font_size", 24)
