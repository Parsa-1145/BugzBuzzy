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
	if (GameManager.won): status.text = "Your code: " + generate_hash(GameManager.solver_group_id, "ECYGDCTU")
	else: status.text = "You don't deserve a hash code"
	# Remove other nodes
	if is_instance_valid(name_input):
		name_input.queue_free()
	if is_instance_valid(continue_button):
		continue_button.queue_free()
	
	# Optional: center or resize status text
	status.add_theme_color_override("font_color", Color(1, 1, 0)) # gold text
	status.add_theme_font_size_override("font_size", 24)

func generate_hash(solver_group_id: String, private_key: String) -> String:
	var combined := solver_group_id + ":" + private_key
	var raw := combined.sha256_buffer()
	var b64 := Marshalls.raw_to_base64(raw)
	b64 = b64.replace("+", "-").replace("/", "_").replace("=", "")
	if b64.length() >= 10:
		return b64.substr(0, 10)
	else:
		return b64 + "-".repeat(10 - b64.length())
