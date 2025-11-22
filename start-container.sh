#!/bin/bash


echo "build container image"
docker image build -t linuxacademy/weather-app:v2 .

echo "docker container starting"
docker container run -d --name weather-dev -p 8082:3001 --env PORT=3001 linuxacademy/weather-app:v2
