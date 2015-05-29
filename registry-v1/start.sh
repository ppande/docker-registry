#!/bin/bash

REGISTRY_LOCATION=/tmp

docker pull redis:latest 
docker pull ppande/registry-v1 
docker pull konradkleine/docker-registry-frontend

docker run -d -p 6379:6379 --name registry-redis --hostname registry-redis redis:latest && \
docker run -d -p 5000:5000 --hostname=registry-v1 --name=registry-v1 \
  --link registry-redis:registry-redis \
  -e SEARCH_BACKEND=sqlalchemy \
  -e STORAGE_PATH=/var/docker-registry \
  -e CACHE_REDIS_HOST=registry-redis \
  -e CACHE_REDIS_PORT=6379 \
  -e CACHE_REDIS_DB=0 \
  -e CACHE_LRU_REDIS_HOST=registry-redis \
  -e CACHE_LRU_REDIS_PORT=6379 \
  -e CACH_LRU_REDIS_DB=0 \
  -v `pwd`/config.yml:/usr/local/lib/python2.7/dist-packages/config/config.yml \
  -v $REGISTRY_LOCATION:/var/docker-registry \
  -e SETTINGS_FLAVOR=dev ppande/registry-v1 && \
docker run -d --link registry-v1:registry-v1 \
  --name registry-frontend \
  --hostname registry-frontend \
  -e ENV_DOCKER_REGISTRY_HOST=registry-v1 \
  -e ENV_DOCKER_REGISTRY_PORT=5000 \
  -p 8280:80 \
  konradkleine/docker-registry-frontend
