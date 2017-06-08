# Official CentOS latest
FROM centos:latest

MAINTAINER Richard Shaw <richard+docker@aggress.net>

ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.10.2.0

# Set the working directory
WORKDIR /root

# All the things
RUN yum makecache fast \
 && yum -y -q update \
 && yum -y -q install java-1.8.0-openjdk-headless git tmux unzip \
 && yum -y -q groupinstall 'Development Tools' \
 && curl -fsSL http://mirror.ox.ac.uk/sites/rsync.apache.org/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz | tar xvz \
 && curl -fsSL -o kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/config/consumer.mm.properties https://raw.githubusercontent.com/aggress/kafka-mirrormaker/master/consumer.mm.properties \
 && curl -fsSL -o kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/config/producer.mm.properties https://raw.githubusercontent.com/aggress/kafka-mirrormaker/master/producer.mm.properties \
 && git clone https://github.com/edenhill/kafkacat.git \
 && cd kafkacat \
 && ./bootstrap.sh \
 && cp kafkacat ../kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/ \
 && cd /root \
 && rm -rf kafkacat \
 && yum -y -q groupremove 'Development Tools' \
 && yum clean all
