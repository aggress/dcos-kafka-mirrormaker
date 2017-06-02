# Official CentOS latest
FROM centos:latest

ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.10.2.0

# Set the working directory
WORKDIR /root

# All the things
RUN yum makecache fast \
 && yum -y -q update \
 && yum -y -q install java-1.8.0-openjdk-headless git \
 && yum clean all \
 && curl http://mirror.catn.com/pub/apache/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz | tar xvz