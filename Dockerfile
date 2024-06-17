FROM node:22.3.0-alpine

RUN apk update && apk upgrade && apk add --no-cache libstdc++ curl gnupg tar xz

WORKDIR /usr/src/app

COPY . .

RUN corepack enable
RUN yarn install
RUN yarn add fastify
RUN yarn add zod fastify-type-provider-zod
RUN yarn add zod zod-validation-error

EXPOSE 1234

CMD [ "yarn", "all" ]
