# Eventbrite Remy

Bienvenue sur **Eventbrite Remy** ! C'est une application de type "Eventbrite" développée en Ruby on Rails, permettant aux utilisateurs de s'inscrire, de se connecter et de créer, gérer ou participer à des événements.

## 🚀 Fonctionnalités principales

* **Authentification utilisateur** : Inscription, connexion et gestion de profil sécurisée grâce à la gem [Devise](https://github.com/heartcombo/devise).
* **Création d'événements** : Les utilisateurs connectés peuvent créer de nouveaux événements en précisant le titre, la description, la date, la durée, le prix et le lieu.
* **Validation des données** : Les événements sont soumis à des règles strictes (ex: titre de 5 caractères minimum, durée multiple de 5, date dans le futur). Les erreurs sont traduites en français (`rails-i18n`).
* **Design moderne** : L'interface est structurée et stylisée avec [Bootstrap 5](https://getbootstrap.com/), intégré via Importmap.

## 🛠 Prérequis techniques

Assurez-vous d'avoir les éléments suivants installés sur votre machine :

* **Ruby** : `3.4.2`
* **Rails** : `~> 8.0.4`
* **Base de données** : SQLite3

## ⚙️ Installation

1. **Cloner le répertoire**
   ```bash
   git clone <URL_DU_REPO>
   cd evenbrite_remy
   ```

2. **Installer les dépendances Ruby**
   ```bash
   bundle install
   ```

3. **Préparer la base de données**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed # Optionnel si un fichier seeds.rb est configuré
   ```

4. **Lancer le serveur de développement**
   ```bash
   rails server
   ```
   L'application sera accessible sur [http://localhost:3000](http://localhost:3000).

## 🗂 Configuration Front-End

Le projet gère ses dépendances JavaScript sans Node.js en utilisant **Importmap for Rails**.
Les librairies comme Bootstrap et Popper.js sont importées directement depuis des CDN (JSPM) dans le fichier `config/importmap.rb` afin d'éviter tout problème de chargement de modules.

## ✉️ Envoi d'emails (Environnement de dev)

La gem `letter_opener` est configurée pour le développement. Lors de l'inscription via Devise ou toute autre action envoyant un email, celui-ci ne sera pas réellement envoyé mais simulé et affiché directement dans le navigateur.

---
*Projet développé dans le cadre de The Hacking Project (THP) - Semaine 8 (Fullstack).*
