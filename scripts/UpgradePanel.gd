extends Node2D

var upgrade_cost_digits = 1

func _ready():
	$UpgradeCostPart/UpgradeCostLabelWrapper/UpgradeCost.text = str(PlayerVariables.upgrade_cost)
	pass


func _on_Button_pressed():
	var upgrade_successful = PlayerVariables.upgradeOxygenTank()
	$UpgradeCostPart/UpgradeCostLabelWrapper/UpgradeCost.text = str(PlayerVariables.upgrade_cost)
	
	if upgrade_successful:
		$UpgradeSoundPlayer.play()
	else:
		$UpgradeFailedSoundPlayer.play()
	
	if str(PlayerVariables.upgrade_cost).length() > upgrade_cost_digits:
		upgrade_cost_digits = str(PlayerVariables.upgrade_cost).length()
		$UpgradeCostPart/UpgradeCostLabelWrapper.position.x -= 20
	
	pass
