#!/bin/bash

set -e

echo "-- Building Nginx + PHP 5.6 image"
docker build -t php-5.6 5.6/

echo
echo "-- Testing server is running"
docker run --name app -d -p 8080:80 php-5.6; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -c 'Hello world'
docker exec -it app php -v | grep -c 'PHP 5.6'

echo
echo "-- Clear"
docker rm -f -v app; sleep 5
docker rmi -f php-5.6

echo
echo "-- Done"