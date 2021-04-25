extends Node2D


func _ready():
# warning-ignore:return_value_discarded
	PlayerVariables.connect("coin_update_signal", self, "_on_PlayerVariables_update_coins")
	updateCoinLabel()
	pass

func _on_PlayerVariables_update_coins():
	updateCoinLabel()
	pass

func updateCoinLabel():
	$CoinLabel.text = str(PlayerVariables.total_coins)
	pass
