FROM openjdk:9-slim

LABEL maintainer="tonylampada <tony.lampada@buser.com>"

ARG BASTILLION_VERSION
ARG BASTILLION_FILENAME_VERSION
ARG DOCKERIZE_VERSION

ENV BASTILLION_VERSION=${BASTILLION_VERSION} \
    BASTILLION_FILENAME=${BASTILLION_FILENAME_VERSION} \
    DOCKERIZE_VERSION=${DOCKERIZE_VERSION}

RUN apt-get update && apt-get -y install wget && \
    wget --quiet https://github.com/bastillion-io/Bastillion-EC2/releases/download/v${BASTILLION_VERSION}/bastillion-ec2-jetty-v${BASTILLION_FILENAME}.tar.gz && \
    wget --quiet https://github.com/jwilder/dockerize/releases/download/v${DOCKERIZE_VERSION}/dockerize-linux-amd64-v${DOCKERIZE_VERSION}.tar.gz && \
    tar xzf bastillion-ec2-jetty-v${BASTILLION_FILENAME}.tar.gz -C /opt && \
    tar xzf dockerize-linux-amd64-v${DOCKERIZE_VERSION}.tar.gz -C /usr/local/bin && \
    mv /opt/Bastillion-EC2-jetty /opt/bastillion && \
    rm bastillion-ec2-jetty-v${BASTILLION_FILENAME}.tar.gz dockerize-linux-amd64-v${DOCKERIZE_VERSION}.tar.gz && \
    apt-get remove --purge -y wget && apt-get -y autoremove && rm -rf /var/lib/apt/lists/* && \
    mkdir /opt/bastillion/jetty/bastillion/WEB-INF/classes/keydb && \
    rm /opt/bastillion/jetty/bastillion/WEB-INF/classes/BastillionConfig.properties

# persistent data of Bastillion is stored here
VOLUME /opt/bastillion/jetty/bastillion/WEB-INF/classes/keydb

# this is the home of Bastillion
WORKDIR /opt/bastillion

# Bastillion listens on 8443 - HTTPS
EXPOSE 8443

# Bastillion configuration template for dockerize
ADD files/BastillionConfig.properties.tpl /opt

# Configure Jetty
ADD files/jetty-start.ini /opt/bastillion/jetty/start.ini

# Custom Jetty start script
ADD files/startBastillionEC2.sh /opt/bastillion/startBastillionEC2.sh

# correct permission for running as non-root (f.e. on OpenShift)
RUN chmod 755 /opt/bastillion/startBastillionEC2.sh && \
    chgrp -R 0 /opt/bastillion && \
    chmod -R g=u /opt/bastillion

# dont run as root
USER 1001

ENTRYPOINT ["/usr/local/bin/dockerize"]
CMD ["-template", \
     "/opt/BastillionConfig.properties.tpl:/opt/bastillion/jetty/bastillion/WEB-INF/classes/BastillionConfig.properties", \
     "/opt/bastillion/startBastillionEC2.sh"]
