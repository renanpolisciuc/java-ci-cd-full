# Obtém a imagem do Java do repositório do git
FROM maven:3.6.3-openjdk-11 as build-stage

ARG APP_VERSION=1.0.0

WORKDIR /my-app

COPY my-app/ ./

RUN mvn clean package

FROM nginx:latest as execution-stage

WORKDIR /java

RUN apt-get -y update && apt-get install -y wget

RUN wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz && tar -xf openjdk-11+28_linux-x64_bin.tar.gz

ENV PATH=/java/jdk-11/bin:$PATH

WORKDIR /app

COPY --from=build-stage /my-app/target/ ./

COPY ./scripts/run.sh ./

COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

ENTRYPOINT [ "./run.sh" ]