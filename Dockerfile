# FIXME: Use a version number instead of the carbon tag
FROM node:carbon

WORKDIR /app

ONBUILD COPY . .

ONBUILD RUN npm install && npm run --if-present build

CMD npm start

EXPOSE 3000