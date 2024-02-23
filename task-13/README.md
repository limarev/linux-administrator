# Docker, docker-compose, dockerfile

Ответы на вопросы в index.html.

docker build -t nginx_modified .
docker run -it -p 80:80 -d nginx_modified:latest
docker pull klimarev/nginx_modified:latest