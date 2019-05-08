ARG NODE_VERSION

FROM node:$NODE_VERSION

ENV ROOT=/app

WORKDIR $ROOT

ONBUILD COPY package*.json $ROOT/

ONBUILD RUN if [ -f $ROOT/package-lock.json ]; \
  then \
    echo 'Running npm ci...' && npm ci; \
  else \
    echo 'Running npm install' && npm install; \
fi

ONBUILD COPY . .

ONBUILD RUN npm run --if-present build

CMD npm start

EXPOSE 3000
