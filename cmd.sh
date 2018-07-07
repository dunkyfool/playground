#!/bin/bash
 
if [ "$1" = "" ]; then
  echo "./cmd.sh (up|down|exec)"

elif [ "$1" = "up" ]; then
  docker-compose up -d

elif [ "$1" = "down" ]; then
  docker-compose kill
  docker-compose rm -f

elif [ "$1" = "exec" ]; then
  winpty docker-compose exec shell bash

elif [ "$1" = "_reset_" ]; then
  docker-machine rm default
  docker-machine create -d virtualbox --virtualbox-cpu-count=2 --virtualbox-memory=3072 --virtualbox-disk-size=10000 default
  docker-machine stop
  exit

elif [ "$1" = "_clean_" ]; then
  docker volume rm $(docker volume ls -qf dangling=true)
  docker volume ls -qf dangling=true | xargs -r docker volume rm
  docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
  docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
  docker rm $(docker ps -qa --no-trunc --filter "status=exited")

elif [ "$1" = "_init_" ]; then
  docker pull microsoft/mssql-server-linux:2017-latest
  docker pull python:2.7.15
  #docker pull ubuntu:16.04
  docker pull redis

else
  docker-compose ${1}

fi
