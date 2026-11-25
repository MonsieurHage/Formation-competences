# EvalComp - Former à évaluer par compétences

Jeu sérieux pour la formation des enseignants à l'évaluation par compétences,
intégrant la taxonomie de Bloom (révisée, Anderson & Krathwohl 2001).

## Objectif pédagogique

- Appliquer les recommandations validées sur l'évaluation par compétences :
  alignement constructif, critères explicites et partagés, feedback descriptif
  et actionnable, évaluation formative/sommative/diagnostique, tâches complexes
  et authentiques, autoévaluation et coévaluation, progression par niveaux de
  Bloom, droit à l'erreur, critères limités, distinction compétence/activité,
  objectivité, diversité des modalités, preuves et traçabilité, équité.
- Intégrer la taxonomie de Bloom : Mémoriser, Comprendre, Appliquer, Analyser,
  Évaluer, Créer.

## Graphismes

Scène 3D avec caméra orthographique fixe et interface redimensionnable.
Les anciens sprites 2D sont conservés comme ressources historiques.
La salle de classe contient 20 élèves et est décorée.
Déplacement en diagonale possible (ZQSD/WASD/flèches).

## Boutons en classe

- Bilan : affiche le résumé des résultats.
- Quitter : ferme le jeu.

## Choix du personnage

Au démarrage, l'utilisateur choisit son genre (homme ou femme).

## Lancer le projet

1. Installer Godot 4.3+.
2. Ouvrir `project.godot`.
3. F5 pour lancer.

Vérifier le parcours avec `godot --headless res://tests/Smoke.tscn`.

## Générateurs historiques

Attention : certains scripts du dossier tools réécrivent les scènes. Ne pas les exécuter sur cette version corrigée sans adaptation.

## Régénérer les sprites (Python/PIL)

```bash
python tools/gen_sprites.py
```

Les PNG sont exportés dans `assets/sprites/` et importés par Godot.

## Modèles 3D HD (Blender)

```bash
blender --background --python blender/generate_hd.py
```

Génère des personnages et mobiliers HD dans `assets/models/hd/`.

## Assets gratuits (CC0)

- Mobilier : Kenney Furniture Kit (CC0) dans `assets/models/kenney/`.
- Personnages : Quaternius (CC0) dans `assets/models/characters/` (man.glb, woman.glb).
- D'autres packs gratuits peuvent être ajoutés dans `assets/models/`.

## Structure

```
EvalCompetences/
  project.godot
  scenes/          # MainMenu, GenderSelect, Classroom, Scenario, Result
  scripts/         # autoloads, player, ui, classroom
  assets/          # sprites, audio
  blender/         # script Blender
  data/
  tests/           # Smoke.tscn
```
## Version corrigée

Ouvrir `project.godot` dans Godot 4 puis lancer avec F5. Voir `LIRE_AVANT_DE_LANCER.txt` pour les corrections, tests et limites.

Tests sans affichage réalisés avec Godot 4.5.1. Le rendu visuel reste à vérifier. Le dépôt contient les sources : aucun export web ou Windows n’est fourni.
