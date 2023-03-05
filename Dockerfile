FROM node:16-alpine
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}
USER node
WORKDIR /home/node
COPY ./package.json ./package-lock.json ./
ENV PATH /home/node_modules/.bin:$PATH
RUN npm install
WORKDIR /home/node
COPY ./ .
RUN npm run build
EXPOSE 1337
CMD ["npm", "run", "develop"]
