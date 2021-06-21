ARG NODE_VERSION

FROM node:$NODE_VERSION

ENV ROOT=/app \
    HOST=0.0.0.0 \
    PORT=3000 \
    NUXT_HOST=0.0.0.0 \
    NUXT_PORT=3000

WORKDIR $ROOT

COPY lib/* /usr/local/lib/liara/

ONBUILD ARG __NODE_NPMMIRROR=false
ONBUILD ARG __NODE_NPMMIRRORURL
ONBUILD ENV __NODE_NPMMIRROR=${__NODE_NPMMIRROR}
ONBUILD ENV __NODE_NPMMIRRORURL=${__NODE_NPMMIRRORURL}

ONBUILD COPY package*.json .npmrc* /app/

ONBUILD RUN /usr/local/lib/liara/configure.sh

ONBUILD COPY . .

ONBUILD RUN npm run --if-present build

ONBUILD ARG __NODE_TIMEZONE=Asia/Tehran
ONBUILD ENV TZ=${__NODE_TIMEZONE}
ONBUILD RUN echo '> Configuring timezone:' $TZ && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezonero

ONBUILD ARG __VOLUME_PATH
ONBUILD ENV __VOLUME_PATH=${__VOLUME_PATH}

CMD ["npm", "start"]

EXPOSE $PORT
