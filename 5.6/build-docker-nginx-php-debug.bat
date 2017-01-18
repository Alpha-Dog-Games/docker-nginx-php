copy /Y %~dp0DockerfileDebug %~dp0Dockerfile

docker build -t nginx-debug .

docker tag nginx-debug:latest 640373737790.dkr.ecr.us-east-1.amazonaws.com/nginx-debug:latest

docker push 640373737790.dkr.ecr.us-east-1.amazonaws.com/nginx-debug:latest

echo Push to Amazon Container Services finished.
