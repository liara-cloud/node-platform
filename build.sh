docker build -t liararepo/node-platform:8 --build-arg NODE_VERSION=8 .
docker build -t liararepo/node-platform:10 --build-arg NODE_VERSION=10 .
docker build -t liararepo/node-platform:11 --build-arg NODE_VERSION=11 .
docker build -t liararepo/node-platform:12 --build-arg NODE_VERSION=12 .
docker build -t liararepo/node-platform:latest --build-arg NODE_VERSION=latest .