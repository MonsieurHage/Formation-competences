extends Node

# Base de données des situations de classe.
# Chaque scénario : situation professionnelle + décision à prendre.
# correct = true pour la/les bonne(s) réponse(s).

var scenarios: Array = [
	{
		"id": "alignement",
		"title": "Aligner l'évaluation avec l'objectif",
		"bloom": "appliquer",
		"principle": "Alignement constructif (Biggs)",
		"situation": "Vous avez prévu que vos élèves sachent « appliquer une formule de périmètre dans une situation réelle ». Pour l'évaluation, vous préparez un QCM qui demande de réciter la formule de mémoire. Est-ce pertinent ?",
		"options": [
			{"text": "Oui, réciter la formule suffit à vérifier la compétence.", "correct": false, "feedback": "Non. Réciter la formule teste le niveau « Mémoriser », pas « Appliquer ». L'évaluation doit viser le même niveau cognitif que l'objectif (alignement constructif)."},
			{"text": "Non. Il faut une tâche où l'élève utilise la formule dans une situation concrète.", "correct": true, "feedback": "Oui. L'évaluation doit reproduire le niveau cognitif visé : ici « Appliquer ». Une mise en situation réelle est alignée avec l'objectif."},
			{"text": "Peu importe le format, seule la note compte.", "correct": false, "feedback": "Non. Le format détermine ce qui est réellement mesuré. Sans alignement, la note n'informe pas sur la compétence visée."}
		]
	},
	{
		"id": "criteres",
		"title": "Critères explicites",
		"bloom": "evaluer",
		"principle": "Critères de réussite partagés",
		"situation": "Vous corrigez une production écrite. Vous avez en tête des critères mais ne les avez pas écrits ni partagés avec les élèves. Quelle est la meilleure pratique ?",
		"options": [
			{"text": "Garder les critères pour soi pour rester libre d'apprécier.", "correct": false, "feedback": "Non. Des critères implicites rendent l'évaluation subjective et empêchent l'élève de progresser."},
			{"text": "Rédiger une grille critériée avec des descripteurs et la partager avec les élèves.", "correct": true, "feedback": "Oui. Une grille critériée clarifie l'attendu, rend l'évaluation transparente et permet l'autoévaluation."},
			{"text": "Donner seulement une note sur 20 sans commentaire.", "correct": false, "feedback": "Non. Une note seule n'informe pas sur ce qui est réussi ni sur ce qui reste à apprendre."}
		]
	},
	{
		"id": "feedback",
		"title": "Feedback actionnable",
		"bloom": "evaluer",
		"principle": "Feedback ciblé sur la tâche",
		"situation": "Un élève a rendu un exposé oral. Vous voulez lui donner un retour utile. Lequel est le plus pertinent ?",
		"options": [
			{"text": "\"Tu as bien travaillé, continue comme ça !\"", "correct": false, "feedback": "Feedback vague et centré sur la personne : il ne dit pas ce qui est réussi ni comment progresser."},
			{"text": "\"Tu as bien structuré ton plan (intro, 3 parties, conclusion). Pour progresser, ajoute des exemples concrets dans la partie 2.\"", "correct": true, "feedback": "Oui. Feedback descriptif, précis, centré sur la tâche et tourné vers l'avenir (conseil procédural)."},
			{"text": "\"Tu n'es pas assez bon en oral.\"", "correct": false, "feedback": "Feedback personnel et négatif, sans piste de progrès. Décourageant et non formateur."}
		]
	},
	{
		"id": "formative",
		"title": "Formative ou sommative ?",
		"bloom": "appliquer",
		"principle": "Fonction de l'évaluation",
		"situation": "En milieu de séquence, vous souhaitez vérifier la compréhension et aider les élèves à progresser avant le contrôle final. Quelle modalité choisissez-vous ?",
		"options": [
			{"text": "Un devoir noté qui compte pour la moyenne.", "correct": false, "feedback": "Non. Noter en cours d'apprentissage stresse et sélectionne; cela contredit le droit à l'erreur en phase de formation."},
			{"text": "Une activité diagnostique avec feedback immédiat, sans note.", "correct": true, "feedback": "Oui. L'évaluation formative (sans note) sert l'apprentissage et permet la régulation."},
			{"text": "Ne rien faire et attendre le contrôle final.", "correct": false, "feedback": "Non. Sans feedback intermédiaire, les erreurs se cristallisent et le contrôle final mesure trop tard."}
		]
	},
	{
		"id": "authentique",
		"title": "Tâche complexe et authentique",
		"bloom": "analyser",
		"principle": "Situation de compétence",
		"situation": "Pour évaluer la compétence « analyser un document historique », vous hésitez entre un exercice de remplissage de tableau et une étude de cas réelle. Quelle est la meilleure option ?",
		"options": [
			{"text": "Le remplissage de tableau : rapide à corriger.", "correct": false, "feedback": "Non. Trop décontextualisé; ne mesure pas le transfert ni l'analyse réelle."},
			{"text": "L'étude de cas authentique avec consignes explicites et grille critériée.", "correct": true, "feedback": "Oui. Une situation de compétence authentique (tâche complexe) évalue le transfert dans un contexte proche du réel."},
			{"text": "Un QCM sur les dates clés.", "correct": false, "feedback": "Non. Teste la mémorisation, pas l'analyse."}
		]
	},
	{
		"id": "autoevaluation",
		"title": "Rôle de l'élève dans l'évaluation",
		"bloom": "evaluer",
		"principle": "Autoévaluation / coévaluation",
		"situation": "Vous souhaitez développer l'autonomie et la métacognition. Quelle pratique intégrez-vous ?",
		"options": [
			{"text": "L'enseignant évalue seul et annonce la note.", "correct": false, "feedback": "Non. L'élève reste passif et ne développe pas sa capacité à s'auto-réguler."},
			{"text": "Former les élèves à l'autoévaluation avec la grille critériée, puis coévaluer.", "correct": true, "feedback": "Oui. Confier un rôle à l'élève dans l'acte d'évaluer développe la métacognition et la responsabilité."},
			{"text": "Faire évaluer par les pairs sans formation préalable.", "correct": false, "feedback": "Non. Sans formation et critères partagés, l'évaluation par les pairs est peu fiable."}
		]
	},
	{
		"id": "progression",
		"title": "Progression par niveaux de Bloom",
		"bloom": "creer",
		"principle": "Progressivité / ZPD",
		"situation": "Vos élèves maîtrisent le niveau « Appliquer ». Vous voulez les faire progresser. Quel objectif est le plus adapté ?",
		"options": [
			{"text": "Exiger directement la création d'un projet original complet.", "correct": false, "feedback": "Non. Trop grand écart : il faut passer par l'analyse et l'évaluation avant la création (progression)."},
			{"text": "Proposer une tâche d'analyse puis d'évaluation critique avant la création.", "correct": true, "feedback": "Oui. Progression graduelle dans la taxonomie de Bloom, respectant la ZPD."},
			{"text": "Rester au niveau « Appliquer » indéfiniment.", "correct": false, "feedback": "Non. Il faut viser des niveaux cognitifs supérieurs pour développer la compétence."}
		]
	},
	{
		"id": "droit_erreur",
		"title": "Droit à l'erreur en formation",
		"bloom": "comprendre",
		"principle": "Évaluation au service de l'apprentissage",
		"situation": "Pendant une activité d'apprentissage, un élève se trompe. Comment réagissez-vous ?",
		"options": [
			{"text": "Noter l'erreur et la compter dans la moyenne.", "correct": false, "feedback": "Non. En phase d'apprentissage, l'erreur est une ressource, pas un échec à sanctionner."},
			{"text": "Utiliser l'erreur comme point de départ d'un feedback et d'une remédiation.", "correct": true, "feedback": "Oui. L'erreur informe l'enseignant et l'élève; elle nourrit la régulation."},
			{"text": "Ignorer l'erreur pour ne pas démoraliser.", "correct": false, "feedback": "Non. Ignorer l'erreur prive l'élève du feedback nécessaire pour progresser."}
		]
	},
	{
		"id": "surcharge",
		"title": "Ne pas évaluer trop de choses à la fois",
		"bloom": "analyser",
		"principle": "Critères limités en nombre",
		"situation": "Vous concevez une grille d'évaluation pour une tâche. Combien de critères privilégiez-vous ?",
		"options": [
			{"text": "15 critères détaillés pour être exhaustif.", "correct": false, "feedback": "Non. Trop de critères diluent l'attention et rendent l'évaluation illisible."},
			{"text": "3 à 5 critères clairs et limités, partagés.", "correct": true, "feedback": "Oui. Des critères clairs et en nombre limité sont plus opérationnels et compréhensibles."},
			{"text": "Un seul critère global « réussite ».", "correct": false, "feedback": "Non. Trop vague pour guider l'élève et rendre compte des apprentissages."}
		]
	},
	{
		"id": "competence_vs_activite",
		"title": "Compétence vs activité",
		"bloom": "evaluer",
		"principle": "Évaluer la compétence, pas l'activité",
		"situation": "Un élève a réalisé une belle affiche mais n'a pas mobilisé la compétence visée (analyser des données). Comment évaluez-vous ?",
		"options": [
			{"text": "Bonne note car l'affiche est esthétique.", "correct": false, "feedback": "Non. On évalue la compétence visée, pas la qualité de l'activité ou de la production annexe."},
			{"text": "Évaluer selon les critères de la compétence « analyser des données », indépendamment de l'affiche.", "correct": true, "feedback": "Oui. La compétence est distincte de l'activité; l'évaluation porte sur la mobilisation des ressources."},
			{"text": "Mélanger les deux dans une note unique.", "correct": false, "feedback": "Non. Mélanger brouille l'information sur ce qui est réellement maîtrisé."}
		]
	},
	{
		"id": "biais",
		"title": "Éviter les biais",
		"bloom": "evaluer",
		"principle": "Objectivité de l'évaluation",
		"situation": "Vous corrigez des copies de mathématiques. Un élève a de mauvaises notes en orthographe. Que faites-vous ?",
		"options": [
			{"text": "Pénaliser l'orthographe dans la note de maths.", "correct": false, "feedback": "Non. Cela introduit un biais : on évalue une compétence non visée et on fausse la mesure."},
			{"text": "Évaluer uniquement la compétence mathématique; signaler l'orthographe à part.", "correct": true, "feedback": "Oui. L'évaluation doit porter sur la compétence visée; les autres aspects sont signalés séparément."},
			{"text": "Ignorer complètement toute erreur.", "correct": false, "feedback": "Non. Les erreurs sont signalées, mais ne faussent pas la note de la compétence visée."}
		]
	},
	{
		"id": "modalites",
		"title": "Diversité des modalités",
		"bloom": "analyser",
		"principle": "Diversité des évaluations",
		"situation": "Vous voulez évaluer l'ensemble des compétences d'un élève sur l'année. Quelle stratégie adoptez-vous ?",
		"options": [
			{"text": "Un seul devoir surveillé en fin d'année.", "correct": false, "feedback": "Non. Une seule modalité ne fait pas émerger toutes les potentialités et concentre le stress."},
			{"text": "Diversifier : oral, écrit, projet, autoévaluation, observation.", "correct": true, "feedback": "Oui. La diversité des modalités révèle des potentialités invisibles par un seul format et équilibre l'évaluation."},
			{"text": "Seulement des QCM automatisés.", "correct": false, "feedback": "Non. Les QCM conviennent aux connaissances factuelles, pas aux compétences complexes."}
		]
	},
	{
		"id": "preuves",
		"title": "Preuves et traçabilité",
		"bloom": "evaluer",
		"principle": "Évaluation fondée sur des preuves",
		"situation": "Vous validez une compétence chez un élève. Sur quoi vous appuyez-vous ?",
		"options": [
			{"text": "Sur une impression générale.", "correct": false, "feedback": "Non. L'évaluation doit s'appuyer sur des preuves observables et traçables."},
			{"text": "Sur plusieurs productions et observations consignées avec la grille critériée.", "correct": true, "feedback": "Oui. La validation repose sur des preuves multiples et documentées (portfolio, observations)."},
			{"text": "Sur une seule réussite isolée.", "correct": false, "feedback": "Non. Une seule performance ne garantit pas la maîtrise durable de la compétence."}
		]
	},
	{
		"id": "equite",
		"title": "Équité et adaptation",
		"bloom": "appliquer",
		"principle": "Adaptation sans renoncer à l'attendu",
		"situation": "Un élève a des besoins éducatifs particuliers. Vous adaptez l'évaluation. Quelle est la bonne démarche ?",
		"options": [
			{"text": "Baisser le niveau de la compétence attendue.", "correct": false, "feedback": "Non. On adapte le support, pas la compétence visée."},
			{"text": "Adapter le support (temps, lisibilité, oralisation) sans changer la compétence évaluée.", "correct": true, "feedback": "Oui. L'adaptation porte sur les obstacles liés à la situation, pas sur l'attendu."},
			{"text": "Dispenser l'élève de l'évaluation.", "correct": false, "feedback": "Non. Tous les élèves sont évalués sur la compétence, avec les adaptations nécessaires."}
		]
	},
	{
		"id": "conception",
		"title": "Évaluation dès la conception",
		"bloom": "creer",
		"principle": "Intégrer l'évaluation à la conception",
		"situation": "Vous préparez une nouvelle séquence. Quand intégrez-vous l'évaluation ?",
		"options": [
			{"text": "À la fin, en improvisant un contrôle.", "correct": false, "feedback": "Non. L'évaluation doit être pensée dès la conception de la séquence."},
			{"text": "Dès le début : identifier les compétences visées, les objectifs et les critères.", "correct": true, "feedback": "Oui. Intégrer l'évaluation dès la conception assure l'alignement et la progressivité."},
			 {"text": "Seulement si les élèves le demandent.", "correct": false, "feedback": "Non. L'évaluation est un levier planifié de l'apprentissage, pas une réaction."}
		]
	},
]

func count() -> int:
	return scenarios.size()

func get_scenario(idx: int) -> Dictionary:
	if idx >= 0 and idx < scenarios.size():
		return scenarios[idx]
	return {}

func shuffle_order() -> Array:
	var order := []
	for i in range(scenarios.size()):
		order.append(i)
	order.shuffle()
	return order