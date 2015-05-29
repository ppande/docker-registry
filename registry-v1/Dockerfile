FROM  debian:wheezy
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
RUN   mkdir /var/docker-registry
ADD   config.yml /usr/local/lib/python2.7/dist-packages/config/config.yml
CMD   ["gunicorn", "--access-logfile", "-", "--debug", "--max-requests", "100", "--graceful-timeout", "3600", "-t", "3600", "-k", "gevent", "-b", "0.0.0.0:5000", "-w", "4", "docker_registry.wsgi:application"]
