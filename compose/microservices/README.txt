Make sure on the docker host the port 80 and 8080 8081 8082 are not in use
run the command line [ docker-compose up -d]
Access from the docker host http://docker-host-ip:80/
You should see the Weather Page with a form asking for Enter a City [                     ] Get Weather
To remove all run the command [docker-compose down] 
[docker volume prune]
