#!/usr/bin/env bash

cat /usr/local/lib/liara/default_npm.config >> .npmrc

if [ "$__NODE_NPMMIRROR" = "true" ]; then
  echo '> Using mirror: ' $__NODE_NPMMIRRORURL
  cat /usr/local/lib/liara/mirror.config >> .npmrc
fi

if [ -f $ROOT/package-lock.json ];
  then
    echo '> Running npm ci...' && npm ci;
  else
    echo '> Running npm install...' && npm install --loglevel=error --no-audit;
fi
