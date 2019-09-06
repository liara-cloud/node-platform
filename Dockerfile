ARG NODE_VERSION

FROM node:$NODE_VERSION

ENV ROOT=/app \
    HOST=0.0.0.0 \
    PORT=3000 \
    NUXT_HOST=0.0.0.0 \
    NUXT_PORT=3000

WORKDIR $ROOT

ONBUILD COPY . .

ONBUILD RUN if [ -f $ROOT/package-lock.json ]; \
  then \
    echo 'Running npm ci...' && npm ci; \
  else \
    echo 'Running npm install' && npm install; \
fi

ONBUILD RUN npm run --if-present build

CMD npm start

EXPOSE $PORT
