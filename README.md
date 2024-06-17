
# API Node.js avec Fastify

## Description

Ce projet est une API Node.js utilisant Fastify, Zod pour la validation des schémas et Docker pour la conteneurisation. L'API permet d'effectuer des opérations mathématiques de base (addition, soustraction, multiplication, division, modulo) et de gérer une liste de noms.

## Prérequis

- Docker

## Installation

### Cloner le dépôt

```sh
git clone [https://github.com/WardenPro/Api_Node.git](https://github.com/WardenPro/Api_Node.git)
cd Api-Node
```

### Construire l'image Docker

Pour construire l'image Docker, exécutez la commande suivante :

```sh
docker build -t api-node .
```

### Lancer le conteneur

Pour lancer le conteneur, exécutez :

```sh
docker run -d -p 3000:3000 api-node
```

L'option `-d` exécute les conteneurs en mode détaché (en arrière-plan).

### Arrêter les services

Pour arrêter les services, utilisez la commande suivante :

```sh
docker stop api-node
```

## Routes de l'API

### Opérations

- **POST /operations**

  Crée une nouvelle opération mathématique.

  **Corps de la requête :**
  ```json
  {
      "lhs": 10,
      "rhs": 5,
      "kind": "ADD"
  }
  ```

  **Réponse :**
  ```json
  {
      "id": 0,
      "message": "created",
      "result": 15
  }
  ```

- **GET /operations**

  Récupère toutes les opérations effectuées.

  **Réponse :**
  ```json
  [
      {
          "lhs": 10,
          "rhs": 5,
          "result": 15
      }
  ]
  ```

- **GET /operations/:id**

  Récupère une opération par son ID.

  **Réponse :**
  ```json
  {
      "lhs": 10,
      "rhs": 5,
      "result": 15
  }
  ```

### Noms

- **POST /names**

  Ajoute un nouveau nom à la liste.

  **Corps de la requête :**
  ```json
  {
      "name": "John Doe"
  }
  ```

  **Réponse :**
  ```json
  {
      "message": "created",
      "id": 0
  }
  ```

- **GET /names**

  Récupère tous les noms.

  **Réponse :**
  ```json
  [
      "Jérôme Cahuzac",
      "Sergueï Choïgou",
      "John Doe"
  ]
  ```

- **GET /names/:id**

  Récupère un nom par son ID.

  **Réponse :**
  ```json
  "John Doe"
  ```

## Exécution locale

Pour exécuter l'application localement sans Docker, vous devez avoir Node.js et Yarn installés sur votre machine.

### Installation des dépendances

```sh
corepack enable
yarn install
yarn add fastify
yarn add zod fastify-type-provider-zod
yarn add zod zod-validation-error
```

### Lancer le serveur

```sh
yarn all
```

Le serveur sera accessible sur `http://localhost:3000`.

