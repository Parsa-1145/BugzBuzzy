extends MarginContainer

@onready var money_label: Label = $VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/MoneyLabel
@onready var health_bar: ProgressBar = $VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HealthBar
@onready var timeLabel : Label = $VBoxContainer/HBoxContainer/TimeLabel
func _process(delta: float) -> void:
	money_label.text = "gold: " + str(GameManager.playerNode.money)
	health_bar.max_value = 8
	health_bar.value = GameManager.playerNode.health
	
	var total_seconds = GameManager.timeLeft
	var minutes = int(total_seconds / 60)
	var seconds = int(total_seconds) % 60

	timeLabel.text = str(minutes) + ":" + str(seconds)
