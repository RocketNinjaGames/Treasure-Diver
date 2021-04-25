extends Node2D

const downwards_movement = PlayerVariables.downwards_movement
const e_const = 2.71828
const extra_coin_start = 3

const oxygen_meter_initial_position = Vector2()
const score_initial_position = Vector2()
const coin_counter_initial_position = Vector2()

var coin_resettable = false
var movement_stopped = false

var idle_sound_playing = false

var dying_return = false
var diving_return = false

func _ready():
	initCoins()
	pass


func _process(delta):
	
	if not movement_stopped:
		
		if Input.is_action_just_pressed("space"):
			$UnderwaterSoundPlayer.play()
			$OceanIdlePlayers/OceanIdleSoundPlayer1.stop()
			$OceanIdlePlayers/OceanIdleSoundPlayer2.stop()
		
		if Input.is_action_pressed("space"):
			if $Player/PlayerBody.position.y < 4820:
				$OxygenMeter.position = $OxygenMeter.position + downwards_movement*delta
				$Score.position = $Score.position + downwards_movement*delta
				$CoinCounter.position = $CoinCounter.position + downwards_movement*delta
				coin_resettable = true
				$UpgradePanel.visible = false
				
				idle_sound_playing = false
		else:
			if $OxygenMeter.position.y > 1050:
				$OxygenMeter.position = $OxygenMeter.position - downwards_movement*delta
			if $Score.position.y > 30:
				$Score.position = $Score.position - downwards_movement*delta
			if $CoinCounter.position.y > 50:
				$CoinCounter.position = $CoinCounter.position - downwards_movement*delta
			if $Player/PlayerBody.position.y == 0:
				$UpgradePanel.visible = true
				if not idle_sound_playing:
					$OceanIdlePlayers/OceanIdleSoundPlayer1.play()
					$OceanIdlePlayers/OceanIdleSoundPlayer2.play(1.7)
					$UnderwaterSoundPlayer.stop()
					if dying_return:
						$Player/PlayerBody/PlayerAnimationPlayer.play("reset")
						dying_return = false
						$Player.resetOxygenDepletion()
					idle_sound_playing = true
	
	if coin_resettable and $Player/PlayerBody.position.y == 0:
		var coins = get_tree().get_nodes_in_group("coins")
		for coin in coins:
			coin.queue_free()
		coin_resettable = false
		initCoins()
	
	pass


func initCoins():
	
	for coin_count in range(2, 9):
		
		if (coin_count > extra_coin_start):
			for extra_coin in range(extra_coin_start + 1, coin_count):
				spawnCoin(pow(e_const, 0.35*coin_count)*300 + 100*(extra_coin - extra_coin_start))
		
		spawnCoin(pow(e_const, 0.35*coin_count)*300)
	
	pass

func spawnCoin(var y_position):
	var coinscene = load("res://scenes/Coin.tscn")
	var coin = coinscene.instance()
	coin.position = Vector2(360, y_position)
	coin.name = "Coin"
	call_deferred("add_child", coin)
	pass


func _on_oxygen_depleted_signal():
	PlayerVariables.resetCoins()
	dying_return = true
	diving_return = true
	pass


func _on_Ocean_Floor_body_entered(body):
	if body is KinematicBody2D:
		movement_stopped = true
	pass
