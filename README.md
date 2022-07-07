# Mattermost

## Clever cloud

### Mise en place

1. Créer une application NodeJS et un addon MySQL
2. You need to set a few environment variables for it to work on Clever Cloud:
- `MM_SERVICESETTINGS_LISTENADDRESS=":8080"`
- `MM_SQLSETTINGS_DATASOURCE="<username>:<password>@tcp(<host>:<port>)/<dbname>?charset=utf8mb4,utf8&readTimeout=30s&writeTimeout=30s"`
- If you are using postgresql: `MM_SQLSETTINGS_DRIVERNAME="mysql"`
- `MM_SQLSETTINGS_MAXOPENCONNS="<maxconnstodb_or_lower>"`
3. Editer les paramètres avec la console système : le système de stockage doit être Amazon S3 (configurer une instance Cellar)

To update mattermost, simply change the wget url in the build.sh to the version you want.

### Déploiement

#### Recette

##### À faire la première fois

Ajouter à le dépôt distant de Clever Cloud en utilisant le `Deployment URL` de recette disponible dans l'[interface de Clever Cloud dans le menu `information` de l'application `Mattermost recette`](https://console.clever-cloud.com/organisations/orga_48e235e2-64a9-4e59-aa6a-d2442a5ab3b7/applications/app_09f24f91-043a-4701-b948-ebbbf4f8cff8/information) :
```shell
git remote add mattermost-recette git+ssh://git@push-n2-par-clevercloud-customers.services.clever-cloud.com/app_09f24f91-043a-4701-b948-ebbbf4f8cff8.git
```

##### À faire à chaque fois

- Récupérer les dernières modifications du dépôt [conseiller-numerique-deploy](https://github.com/anct-cnum/conseiller-numerique-deploy).
- Copier le fichier [config-recette.json] en le renommant en [config.json] (https://github.com/anct-cnum/conseiller-numerique-deploy/blob/main/mattermost/config-recette.json) depuis le projet [conseiller-numerique-deploy](https://github.com/anct-cnum/conseiller-numerique-deploy) à la racine de ce projet.
- Supprimer le fichier `.gitignore`
- Ajouter ces deux modifications :
```shell
git add .gitignore config.json
```
- Faire un commit pour le déploiement, le message importe peu :
```shell
git commit -m "deploy"
```
- Publier **sur le dépôt de recette** :
```shell
git push mattermost-recette recette:master --force
```
- Une fois les modifications publiées, les changements temporaires appliqués au dépôt pour le déploiement doivent être annulés :
```shell
git reset --hard HEAD~1
```

#### Production

##### À faire la première fois

Ajouter à le dépôt distant de Clever Cloud en utilisant le `Deployment URL` de recette disponible dans l'[interface de Clever Cloud dans le menu `information` de l'application `Mattermost prod`](https://console.clever-cloud.com/organisations/orga_48e235e2-64a9-4e59-aa6a-d2442a5ab3b7/applications/app_5767f9d4-9689-4db3-bedc-b62f308275fb/information) :
```shell
git remote add mattermost-prod git+ssh://git@push-n2-par-clevercloud-customers.services.clever-cloud.com/app_5767f9d4-9689-4db3-bedc-b62f308275fb.git
```

##### À faire à chaque fois

- Récupérer les dernières modifications du dépôt [conseiller-numerique-deploy](https://github.com/anct-cnum/conseiller-numerique-deploy).
- Copier le fichier [config.json](https://github.com/anct-cnum/conseiller-numerique-deploy/blob/main/mattermost/config.json) depuis le projet [conseiller-numerique-deploy](https://github.com/anct-cnum/conseiller-numerique-deploy) à la racine de ce projet.
- Supprimer le fichier `.gitignore`
- Ajouter ces deux modifications :
```shell
git add .gitignore config.json
```
- Faire un commit pour le déploiement, le message importe peu :
```shell
git commit -m "deploy"
```
- Publier **sur le dépôt de production** :
```shell
git push mattermost-prod main:master --force
```
- Une fois les modifications publiées, les changements temporaires appliqués au dépôt pour le déploiement doivent être annulés :
```shell
git reset --hard HEAD~1
```

## Installation locale

### Base de données

#### Avec Docker

Créer un volume qui sera persistant après l'extinction du conteneur :

```shell
docker volume create postgres.mattermost
```

Télécharger et lancer l'image de postgres avec les informations d'identifications par défaut de Mattermost :

```shell
docker run -d --rm --name=postgres -p 5432:5432 -v postgres.mattermost:/var/lib/postgresql/data -e POSTGRES_PASSWORD=mostest -e POSTGRES_USER=mmuser -e POSTGRES_DB=mattermost_test postgres:alpine
```

### Lancement de Mattermost

Télécharger une version de Mattermost, exemple avec 5.39.0 :
```shell
wget https://releases.mattermost.com/5.39.0/mattermost-5.39.0-linux-amd64.tar.gz -O - | tar -xvz
```

Pour lancer Mattermost, il faut d'abord aller dans le dossier `mattermost` :
```shell
cd ./mattermost
```
puis exécuter le binaire :
```shell
./bin/mattermost
```

### Dépannage

- Si l'erreur `"caller":"app/plugin.go:151","msg":"Failed to start up plugins","error":"mkdir ./client/plugins: no such file or directory"` apparaît, il faut démarrer l'application depuis le dossier `mattermost` ou modifier le chemin de `ClientDirectory` par un chemin absolu dans `config.json` : [issue 13913](https://github.com/mattermost/mattermost-server/issues/13913).
- Si Mattermost ne parvient pas à se connecter à la base de données, supprimer puis recréer le volume docker et vérifier la correspondance entre les informations de connexions fournies en paramètres lors du lancement du conteneur et celles contenues dans le fichier de configuration de Mattermost.

## Plugins

### Voice messaging

Télécharger le plugin [Voice messaging](https://mattermost.com/marketplace/voice-messaging/) depuis la [page des versions disponibles](https://github.com/streamer45/mattermost-plugin-voice/releases) vers le dossier `plugins` de Mattermost.  
Exemple pour la version 0.2.2 :
```shell
mkdir ./mattermost/plugins/ # Si ce dossier n'existe pas déjà
wget https://github.com/streamer45/mattermost-plugin-voice/releases/download/v0.2.2/com.mattermost.voice-0.2.2.tar.gz -O - | tar -xzvf - -C ./mattermost/plugins/
```
Dans le fichier `config.json`, ajouter une entrée pour `com.mattermost.voice` dans la propriété `PluginStates` :
```json
"com.mattermost.voice": {
"Enable": true
}
```
