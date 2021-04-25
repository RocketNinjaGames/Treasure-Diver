extends TextureProgress

var max_timer_value = 4

var timer_running = false
var timer_value = 0
var depleted = false

var oxygen_meter_node

signal oxygen_depleted_signal

func _ready():
	value = 0
	set_tint_progress(Color(0.6, 0.6, 0.6))
	oxygen_meter_node = get_node("..")
# warning-ignore:return_value_discarded
	PlayerVariables.connect("upgrade_oxygen_signal", self, "_on_PlayerVariables_upgrade_oxygen")
	pass

func _process(delta):
	
	if(Input.is_action_just_pressed("space")):
		timer_running = true
		depleted = false
	
	if timer_value >= max_timer_value:
		Input.action_release("space")
		timer_running = false
	
	if(Input.is_action_just_released("space")):
		timer_running = false
	
	if timer_running or oxygen_meter_node.position.y > 1050:
		value = (timer_value / max_timer_value)*100
		timer_value += delta
	
	
	if not timer_running and (value > 0 and timer_value > 0) and oxygen_meter_node.position.y <= 1050:
		timer_value -= delta*(PlayerVariables.upgrade_stage + 3)*2
		value = (timer_value / max_timer_value)*100
	
	if (timer_value < 0) or (value < 0):
		timer_value = 0
		value = 0
	
	if value > 50:
		tint_under = Color(0.94, 0.14, 0.24)
	else:
		tint_under = Color(0.11, 0.84, 0.91)
	
	if value >= 100 and not depleted:
		emit_signal("oxygen_depleted_signal")
		depleted = true
	
	pass

func _on_PlayerVariables_upgrade_oxygen():
	if PlayerVariables.upgrade_stage >= 1:
		max_timer_value *= 1.3
	else:
		max_timer_value *= 1.5
	pass
