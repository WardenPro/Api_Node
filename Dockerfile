# Utiliser l'image de base alpine avec Node.js préinstallé
FROM alpine:3.19

# Définir la version de Node.js et de Yarn
ENV NODE_VERSION 22.3.0
ENV YARN_VERSION 1.22.22

# Ajouter l'utilisateur node
RUN addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node

# Installer Node.js et ses dépendances
RUN apk add --no-cache libstdc++ \
    && apk add --no-cache --virtual .build-deps curl gnupg tar \
    && curl -fsSLO --compressed "https://unofficial-builds.nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64-musl.tar.xz" \
    && tar -xJf "node-v$NODE_VERSION-linux-x64-musl.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
    && rm -f "node-v$NODE_VERSION-linux-x64-musl.tar.xz" \
    && node --version \
    && npm --version

# Installer Yarn
RUN curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
    && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
    && ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
    && rm yarn-v$YARN_VERSION.tar.gz \
    && yarn --version

# Définir le répertoire de travail
WORKDIR /usr/src/app

# Copier les fichiers de votre projet dans l'image Docker
COPY . .

# Installer les dépendances de votre projet
RUN yarn install
RUN yarn add fastify
RUN yarn add zod fastify-type-provider-zod
RUN yarn add zod zod-validation-error

# Exposer le port que votre application utilise
EXPOSE 3000

# Définir le point d'entrée pour le conteneur
CMD [ "yarn", "start" ]
