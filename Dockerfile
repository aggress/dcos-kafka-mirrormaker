# Use an official Python runtime as a base image
FROM centos:latest

# Set the working directory to /app
WORKDIR /root

# Copy the current directory contents into the container at /app
COPY consumer.properties producer.properties ./

# Image update
RUN yum -y -q install deltarpm \
&& yum -y -q update \
&& yum -y -q install java-1.7.0-openjdk-headless \
&& yum clean all \
&& curl -fsSLO http://mirror.catn.com/pub/apache/kafka/0.10.2.1/kafka_2.11-0.10.2.1.tgz \
&& tar zxf kafka_2.11-0.10.2.1.tgz && rm -f kafka_2.11-0.10.2.1.tgz

