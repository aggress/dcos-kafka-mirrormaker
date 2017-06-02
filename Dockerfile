# Use an official Python runtime as a base image
FROM centos:latest

ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.10.2.0

# Set the working directory to /app
WORKDIR /root

# Copy the current directory contents into the container at /app
COPY consumer.properties producer.properties ./

# Image update
RUN yum makecache fast \
 && yum -y -q update \
 && yum -y -q install java-1.8.0-openjdk-headless \
 && yum clean all \
 && curl http://mirror.catn.com/pub/apache/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz | tar xvz