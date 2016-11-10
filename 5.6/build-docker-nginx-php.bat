
REM Build the image with new source code
docker build -t alphadoggames/nginx-php-5.6 .

REM Upload to Docker Hub
docker push alphadoggames/nginx-php-5.6
