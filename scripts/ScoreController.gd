extends Node2D

var player_node
var start_y_position

func _ready():
	$ScoreLabel.text = "0"
	$ScoreLabel.align = Label.ALIGN_RIGHT
	player_node = get_node("../Player/PlayerBody")
	start_y_position = player_node.position.y
	pass


func _process(_delta):
	
	var current_score = round(player_node.position.y)
	
	if current_score <= 0:
		$ScoreLabel.text = "0"
	else:
		$ScoreLabel.text = str(current_score)
	
	pass
