#!/bin/bash

docker build -t isaudits/beef .
docker image prune -f