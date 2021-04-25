extends Node

const downwards_movement = Vector2(0, 200)

var total_coins = 0
var upgrade_stage = 0
var upgrade_cost = 10

signal coin_update_signal
signal upgrade_oxygen_signal

func _ready():
	pass

func addCoin():
	total_coins += 1
	emit_signal("coin_update_signal")
	pass

func resetCoins():
	total_coins = 0
	emit_signal("coin_update_signal")
	pass

func upgradeOxygenTank() -> bool:
	
	if total_coins >= upgrade_cost:
		total_coins -= upgrade_cost
		upgrade_cost = round(upgrade_cost * 1.5)
		emit_signal("upgrade_oxygen_signal")
		emit_signal("coin_update_signal")
		return true
	
	return false
