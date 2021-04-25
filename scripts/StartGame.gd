extends Node2D

func _ready():
	$OceanIdlePlayers/OceanIdleSoundPlayer1.play()
	$OceanIdlePlayers/OceanIdleSoundPlayer2.play(1.7)
	$AnimationPlayer.play("ButtonIdle")
	pass

func _on_StartGameButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/World.tscn")
	pass
