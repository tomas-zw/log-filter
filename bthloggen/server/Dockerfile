FROM node:14

WORKDIR /server

COPY src/ ./src

COPY package*.json ./

COPY index.js ./

RUN npm install

ENTRYPOINT [ "npm", "start"]
