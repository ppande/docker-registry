FROM  ubuntu:14.04
MAINTAINER  Pushkar Pande <pushkar.in@gmail.com>
RUN   apt-get update && \
      apt-get install -y \
        build-essential \
        python-dev \
        libevent-dev \
        python-pip \
        liblzma-dev \
        python-sqlalchemy \
        python-redis \
        swig \
        libssl-dev \
        openssl

RUN   pip install docker-registry
 
RUN   apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN   locale-gen en_US.UTF-8 && dpkg-reconfigure locales
RUN   mkdir /var/docker-registry
#RUN   cd /usr/local/lib/python2.7/dist-packages/config && \
#      cp config_sample.yml config.yml && \
#      sed -i.bak 's/\/tmp\//\/var\/docker-registry\//g' config.yml
CMD   ["gunicorn", "--access-logfile", "-", "--debug", "--max-requests", "100", "--graceful-timeout", "3600", "-t", "3600", "-k", "gevent", "-b", "0.0.0.0:5000", "-w", "4", "docker_registry.wsgi:application"]