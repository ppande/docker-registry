#!/bin/bash

docker run -d -p 5000:5000 --hostname=registry --name=registry \
  -v `pwd`/config.yml:/usr/local/lib/python2.7/dist-packages/config/config.yml \
  -e "SETTINGS_FLAVOR=dev" ppande/registry-v1
