extends Node

# Taxonomie de Bloom révisée (Anderson & Krathwohl, 2001)
# Niveaux cognitifs du plus simple au plus complexe
const LEVELS := [
	{"id": "memoriser", "label": "Mémoriser", "color": Color(0.95, 0.35, 0.35), "verbes": ["citer", "définir", "nommer", "énumérer", "rappeler"]},
	{"id": "comprendre", "label": "Comprendre", "color": Color(0.95, 0.6, 0.2), "verbes": ["expliquer", "résumer", "illustrer", "reformuler", "interpréter"]},
	{"id": "appliquer", "label": "Appliquer", "color": Color(0.95, 0.85, 0.2), "verbes": ["appliquer", "calculer", "résoudre", "utiliser", "mettre en pratique"]},
	{"id": "analyser", "label": "Analyser", "color": Color(0.4, 0.8, 0.35), "verbes": ["analyser", "comparer", "distinguer", "classer", "décomposer"]},
	{"id": "evaluer", "label": "Évaluer", "color": Color(0.25, 0.55, 0.95), "verbes": ["justifier", "critiquer", "apprécier", "argumenter", "valider"]},
	{"id": "creer", "label": "Créer", "color": Color(0.7, 0.35, 0.95), "verbes": ["concevoir", "élaborer", "composer", "inventer", "planifier"]},
]

func level_index(id: String) -> int:
	for i in range(LEVELS.size()):
		if LEVELS[i]["id"] == id:
			return i
	return -1

func level_label(id: String) -> String:
	var i := level_index(id)
	if i >= 0:
		return LEVELS[i]["label"]
	return id

func level_color(id: String) -> Color:
	var i := level_index(id)
	if i >= 0:
		return LEVELS[i]["color"]
	return Color.WHITE