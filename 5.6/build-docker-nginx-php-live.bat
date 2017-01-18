copy /Y %~dp0DockerfileLive %~dp0Dockerfile

docker build -t nginx-release .

docker tag nginx-release:latest 640373737790.dkr.ecr.us-east-1.amazonaws.com/nginx-release:latest

docker push 640373737790.dkr.ecr.us-east-1.amazonaws.com/nginx-release:latest

echo Push to Amazon Container Services finished.
