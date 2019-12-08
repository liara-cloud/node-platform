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
    echo 'Running npm install' && npm install --loglevel=error --no-audit; \
fi

ONBUILD RUN npm run --if-present build

ONBUILD ARG __NODE_NPMAUDIT=false
ONBUILD ARG __NODE_NPMAUDITDESTINATION

ONBUILD RUN if [ "$__NODE_NPMAUDIT" = "true" ]; then \
  echo 'Auditing package dependencies for security vulnerabilities...'; \
  npm audit --production --json > liara__audit.json; \
  curl --upload-file /app/liara__audit.json $__NODE_NPMAUDITDESTINATION; \
  rm liara__audit.json; \
fi

ONBUILD ARG __NODE_TIMEZONE=Asia/Tehran
ONBUILD ENV TZ=${__NODE_TIMEZONE}
ONBUILD RUN echo 'Configuring timezone:' $TZ && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezonero

ONBUILD ARG __VOLUME_PATH
ONBUILD ENV __VOLUME_PATH=${__VOLUME_PATH}

CMD npm start

EXPOSE $PORT
