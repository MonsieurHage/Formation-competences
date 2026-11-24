# Évaluer par compétences — parcours de formation

Mini-site statique en français, sans installation, sans serveur applicatif ni bibliothèque externe.

## Publier sur GitHub Pages
1. Créer un dépôt GitHub (par exemple `formation-competences`).
2. Déposer **le contenu de ce dossier** à la racine du dépôt, notamment `index.html`, les quatre pages, `style.css` et `app.js`.
3. Dans le dépôt : Settings → Pages → Build and deployment → Deploy from a branch. Choisir `main` et `/ (root)`, puis Save.
4. Ouvrir l'adresse indiquée par GitHub Pages une fois le déploiement terminé.

## Utilisation
- Ouvrir `index.html` pour un aperçu local (un serveur statique est conseillé pour une sauvegarde homogène entre les pages, par exemple `python -m http.server 8000` depuis ce dossier).
- Les réponses sont sauvegardées dans le stockage local du navigateur, sur la même origine. Pas de compte, de transmission de données ou de synchronisation entre appareils.
- Chaque atelier possède un export texte et une impression/PDF via le navigateur. L'accueil propose un export JSON global pour archiver les données (pas de réimport automatique dans cette version).
- Ne pas renseigner de noms d'élèves ou de données personnelles. Les productions d'élèves fournies dans l'atelier 3 sont fictives.
- Le bouton de validation enregistre une auto-déclaration de fin d'atelier, pas une certification de compétence.

## Parcours
1. Distinguer les notions de l'évaluation.
2. Transformer une évaluation disciplinaire avec Bloom et prévoir un transfert.
3. Construire et tester une grille critériée, comparer deux jugements.
4. Expérimenter autoévaluation, feedback, révision et remédiation.

Adaptation des ateliers proposés à partir de la présentation « Évaluer par compétences » (CNFETP). Les exemples et dispositifs interactifs sont des propositions pédagogiques, non des données de recherche.

## Accès progressif (version 2)
- Chaque atelier requiert un code distinct communiqué par le formateur ; le premier atelier est également verrouillé. Les ateliers doivent être ouverts dans l’ordre. Les réponses ne sont pas soumises à une validation automatique de fin pour passer au suivant.
- Le bouton « ? Déroulement » ouvre les étapes, les durées et la production attendue.
- Le déverrouillage est mémorisé localement. Le bouton « Reverrouiller les ateliers » sur l’accueil réinitialise les accès sans effacer les productions.
- Les codes sont remis séparément au formateur. Le contrôle est pédagogique, pas une sécurité : le JavaScript et le stockage local d’un site statique restent inspectables et modifiables.
- Utiliser GitHub Pages (HTTPS) ou un serveur localhost pour garantir la disponibilité de Web Crypto et la persistance entre pages.
