extends Node2D
class_name Player

const downwards_movement = PlayerVariables.downwards_movement
const start_y_position = 340

var movement_stopped = false
var oxygen_depleted = false

func _ready():
	position = Vector2(360, start_y_position)
	pass

func _process(_delta):
	
	if (Input.is_action_pressed("space")) and not movement_stopped:
		$PlayerBody.move_and_slide(downwards_movement)
	else:
		if $PlayerBody.position.y > 0 and not movement_stopped:
			$PlayerBody.move_and_slide(-downwards_movement)
		elif $PlayerBody.position.y < 0 and not movement_stopped:
			$PlayerBody.position.y = 0
	
	
	pass


func _on_Ocean_Floor_body_entered(body):
	if body is KinematicBody2D:
		movement_stopped = true
		$PlayerBody/SubmarineTouchdownPlayer.play()
	pass


func _on_oxygen_depleted_signal():
	if not oxygen_depleted:
		$PlayerBody/OxygenDepletionSound.play()
		$PlayerBody/PlayerAnimationPlayer.play("oxygen_depletion")
		oxygen_depleted = true
	pass

func resetOxygenDepletion():
	oxygen_depleted = false
	pass


func _on_SubmarineTouchdownPlayer_finished():
	get_tree().change_scene("res://scenes/GameEnd.tscn")
	pass
