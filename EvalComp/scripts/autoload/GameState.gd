extends Node

# État global du jeu
enum Screen { MAIN_MENU, GENDER_SELECT, CLASSROOM, SCENARIO, RESULT }

var current_screen: Screen = Screen.MAIN_MENU
var gender: String = "male"  # "male" | "female"
var interlocutor_name: String = "Élève"
var classroom_position: Vector3 = Vector3(2, 0, -5.8)

var player_name: String = "Enseignant"
var score: int = 0
var xp: int = 0
var level: int = 1
var scenarios_completed: Array = []  # indices
var scenario_order: Array = []  # ordre aléatoire des scénarios
var scenario_answers: Dictionary = {}  # idx -> option index chosen
var scenario_points: Dictionary = {}  # idx -> points awarded
var current_scenario_index: int = -1
var in_scenario: bool = false
var reduce_animations: bool = false

func reset_run() -> void:
	classroom_position = Vector3(2, 0, -5.8)
	score = 0
	xp = 0
	level = 1
	scenarios_completed.clear()
	scenario_answers.clear()
	scenario_points.clear()
	current_scenario_index = -1
	in_scenario = false
	scenario_order = ScenariosDB.shuffle_order()

func add_score(points: int) -> void:
	score += points
	xp += points
	# level up every 100 xp
	while xp >= level * 100:
		xp -= level * 100
		level += 1

func is_completed(idx: int) -> bool:
	return scenarios_completed.has(idx)

func mark_completed(idx: int) -> void:
	if not scenarios_completed.has(idx):
		scenarios_completed.append(idx)

func award_scenario(idx: int, option_index: int, points: int) -> void:
	# Only award once
	if scenarios_completed.has(idx):
		# already awarded; just record answer if missing
		if not scenario_answers.has(idx):
			scenario_answers[idx] = option_index
			scenario_points[idx] = 0
		return
	scenario_answers[idx] = option_index
	scenario_points[idx] = points
	scenarios_completed.append(idx)
	if points > 0:
		add_score(points)

func max_score() -> int:
	return ScenariosDB.count() * 100