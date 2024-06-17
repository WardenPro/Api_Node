FROM node:22.3.0-alpine

RUN apk add --no-cache libstdc++ curl gnupg tar xz

WORKDIR /usr/src/app

COPY . .

RUN corepack enable && yarn

EXPOSE 3000

CMD [ "yarn", "all" ]
