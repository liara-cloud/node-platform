# TODO: Version number should be customizable
FROM node:8.11

WORKDIR /app

ONBUILD COPY . .

ONBUILD RUN npm install && npm run --if-present build

CMD npm start

EXPOSE 3000
