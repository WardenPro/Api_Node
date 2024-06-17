# Utilise une image de base. Exemple : ubuntu:20.04
FROM ubuntu:20.04

# Met à jour les paquets et installe les dépendances nécessaires.
# Exemple : RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y <paquet>

# Copie des fichiers ou dossiers du système de fichiers local vers le système de fichiers de l'image.
# Exemple : COPY . /app
COPY <chemin_du_système_de_fichiers_local> <chemin_dans_l'image>

# Ajoute des fichiers depuis une URL ou un fichier tar local au système de fichiers de l'image.
# Exemple : ADD https://example.com/big.tar.xz /usr/src/things/
ADD <source_url_ou_tar_local> <destination_dans_image>

# Définit la variable d'environnement. Exemple : ENV MY_NAME="John Doe"
ENV <clé> <valeur>

# Exécute des commandes lors de la construction de l'image.
# Cela diffère de RUN car CMD n'est exécuté qu'à l'exécution du conteneur.
# Exemple : CMD ["echo", "Hello world"]
CMD ["executable","param1","param2"]

# Expose des ports. Exemple : EXPOSE 80/tcp
EXPOSE <port> [<tcp/udp>]

# Définit le répertoire de travail où s'exécutent les commandes RUN, CMD, ENTRYPOINT, ADD et COPY.
# Exemple : WORKDIR /path/to/workdir
WORKDIR <chemin_du_répertoire_de_travail>

# Exécute une commande lors du lancement du conteneur. Peut être utilisé pour configurer un conteneur qui sera utilisé comme base pour d'autres images.
# Exemple : ENTRYPOINT ["executable", "param1", "param2"]
ENTRYPOINT ["executable", "param1", "param2"]

# Copie les fichiers, les répertoires ou les URL distants et ajoute un utilisateur.
# Exemple : USER myuser
USER <nom_d'utilisateur>

# Ajoute des points de montage de volume.
# Exemple : VOLUME ["/data"]
VOLUME ["<chemin_du_volume>"]

# Ajoute des labels à votre image pour aider à l'organiser avec des métadonnées supplémentaires.
# Exemple : LABEL version="1.0"
LABEL <clé>="<valeur>"

# Arguments qui peuvent être passés au Dockerfile au moment de la construction de l'image.
# Exemple : ARG VERSION=latest
ARG <nom>=[<valeur_par_défaut>]

# Définit les commandes de santé qui sont exécutées pour vérifier que votre application fonctionne bien.
# Exemple : HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost/ || exit 1
HEALTHCHECK --interval=<intervalle> --timeout=<temps_limite> CMD <commande>

# OnBuild déclenche des instructions à exécuter lorsqu'une image est utilisée comme base pour une autre image.
# Exemple : ONBUILD RUN /usr/local/bin/python-build --dir /app
ONBUILD <INSTRUCTION>
