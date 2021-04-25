extends Node2D


func _ready():
	add_to_group("coins")
	pass

func _on_CoinArea_body_entered(body):
	if body is KinematicBody2D:
		PlayerVariables.addCoin()
		$AudioStreamPlayer2D.play()
		$AnimationPlayer.play("collect")
	pass


func _on_AudioStreamPlayer2D_finished():
	call_deferred("queue_free")
	pass
