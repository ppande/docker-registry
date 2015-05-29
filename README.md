Docker registry
----------------
<h5>Starting registry-v1</h5>
```
docker run -d -p 5000:5000 --net=host --name=registry-v1 \
  -e SEARCH_BACKEND=sqlalchemy \
  -e STORAGE_PATH=/var/docker-registry \
  -v `pwd`/config.yml:/usr/local/lib/python2.7/dist-packages/config/config.yml \
  -v $REGISTRY_LOCATION:/var/docker-registry \
  -e SETTINGS_FLAVOR=dev ppande/registry-v1
```
This exposes port 5000 on the host and the new registry location thus becomes <hostname:port>.

<h5>Enabling redis cache</h5>
For caching using redis, you can optionally define the following environment variables as part of the command line for starting a registry-v1 container.
```
  -e CACHE_REDIS_HOST=<redis_host_ip> \
  -e CACHE_REDIS_PORT=<redis_port> \
  -e CACHE_REDIS_DB=0 \
  -e CACHE_LRU_REDIS_HOST=<redis_host_ip> \
  -e CACHE_LRU_REDIS_PORT=<redis_port> \
  -e CACH_LRU_REDIS_DB=1 \
```

<h5>Why use `--net=host` for registry-v1?</h5>
`--net=host` tells docker to not containerize networking and instead use the host networking stack. In my experience this option has worked without any problem when pushing large images/layers.
