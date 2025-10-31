class_name EndGameDialog
extends MarginContainer

func setState(message: String):
	$ColorRect/MarginContainer/VBoxContainer/WinState.text = message
