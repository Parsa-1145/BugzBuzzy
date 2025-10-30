extends CanvasLayer

@onready var money_label: Label = $TopLeft/MoneyLabel
@onready var health_bar: ProgressBar = $TopLeft/HealthBar

func _process(delta: float) -> void:
	money_label.text = str(GameManager.playerNode.money)
	health_bar.max_value = 10
	health_bar.value = GameManager.playerNode.health
