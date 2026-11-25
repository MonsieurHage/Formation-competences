extends Node
func _ready() -> void:
	GameState.reset_run()
	GameState.current_scenario_index = 0
	var packed = load("res://scenes/Scenario.tscn")
	var inst = packed.instantiate()
	add_child(inst)
	print("FLOW: scenario loaded")
	await get_tree().process_frame
	inst._answer(1)
	await get_tree().process_frame
	print("FLOW: after answer score=", GameState.score, "continue_visible=", inst.continue_btn.visible)
	print("FLOW: feedback=", inst.feedback_label.text.substr(0,40))
	get_tree().quit()