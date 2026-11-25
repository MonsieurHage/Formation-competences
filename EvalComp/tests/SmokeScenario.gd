extends Node
func _ready() -> void:
	GameState.current_scenario_index = 0
	var packed = load("res://scenes/Scenario.tscn")
	var inst = packed.instantiate()
	add_child(inst)
	print("SMOKE: scenario loaded")
	# simulate answer
	await get_tree().process_frame
	inst._answer(0)
	await get_tree().process_frame
	print("SMOKE: after answer, continue visible =", inst.continue_btn.visible)
	print("SMOKE: answered =", inst.answered)
	print("SMOKE: score =", GameState.score)
	print("SMOKE: completed =", GameState.scenarios_completed)
	# simulate double click
	inst._answer(1)
	await get_tree().process_frame
	print("SMOKE: after double answer, score =", GameState.score, "(should be same)")
	get_tree().quit()