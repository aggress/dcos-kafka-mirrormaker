# Official CentOS latest
FROM centos:latest

MAINTAINER Richard Shaw <richard+docker@aggress.net>

ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.10.2.0
ENV ZK_HOSTS=localhost:2181

# Set the working directory
WORKDIR /root

# All the things
RUN yum makecache fast \
 && yum -y -q update \
 && yum -y -q install java-1.8.0-openjdk-headless \
    java-1.8.0-openjdk-devel \
    git \
    unzip \
 && curl -fsSL http://mirror.ox.ac.uk/sites/rsync.apache.org/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz | tar xvz \
 && curl -fsSL https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo \
 && yum -y -q install sbt \
 && git clone https://github.com/yahoo/kafka-manager.git \
 && cd kafka-manager \
 && git fetch --tags \
 && KAFKA_MANAGER_REL=$(git describe --tags `git rev-list --tags --max-count=1`) \
 && sbt clean dist \
 && unzip -d /root/ /root/kafka-manager/target/universal/kafka-manager-"$KAFKA_MANAGER_REL".zip \
 && rm -rf /root/kafka-manager \
 && yum -y -q remove sbt java-1.8.0-openjdk-devel git \
 && yum clean all

EXPOSE 9000

WORKDIR /root/kafka-manager-"{$KAFKA_MANAGER_REL}"

ENTRYPOINT ["./bin/kafka-manager","-Dconfig.file=conf/application.conf"]
