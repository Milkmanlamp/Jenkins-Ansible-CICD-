**Step 1: Install Java**
java installation for jenkins
``` bash
sudo apt update

sudo apt install fontconfig openjdk-17-jre -y
```

## Install Docker 
``` bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## Give user permissions to docker and apply
``` bash
sudo usermod -aG docker $USER
newgrp docker 
```

## Make a docker compose file, im using the stable version of jenkins
``` yml
version: '3.8'

services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    user: root
    ports:
      - "8080:8080" # Maps port the vms port 8080 to port 8080 in Jenkins
      - "50000:50000"
    volumes:
      - jenkins_data:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock # Allows Jenkins to control Docker
    restart: unless-stopped

volumes:
  jenkins_data:

```

## Start the compose file for jenkins 
``` bash
docker compose up -d
```

## Get the jenkins startup password to log in inside the container
``` bash 
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

## Log in and install plugins related to the project
Use the ip of the host vm and the port to log into the browser

![[Pasted image 20260322232620.png]]

## Install Docker CLI inside Jenkins

Because Jenkins needs to run Docker commands to build your website, it needs the Docker software installed _inside_ its container.

Enter the Jenkins container as the root user:
``` bash
docker exec -it -u root jenkins /bin/bash
```

Inside the container, install the Docker CLI (command line interface):
``` bash
apt-get update

apt-get install -y docker.io

exit
```
  
## Create a Repo in github or bitbucket and make a Jenkinsfile and a webpage


#### Jenkinsfile
```
pipeline {
    agent any

    stages {
        stage('Deploy to Web Server') {
            steps {
                sh '''
                    docker stop my-website || true
                    docker rm my-website || true
                    docker run -d --name my-website -p 80:80 nginx:latest
                    docker cp $WORKSPACE/. my-website:/usr/share/nginx/html/
                '''
            }
        }
    }
}


```

## Go in the jenkins dashboard and get the definition from SCM and poll every min
## Put in the repo details and login with preferred method


# Bash script version made from my testing on multiple set ups

``` bash
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# 0) Update package manager
sudo apt update && sudo apt upgrade -y
# 3) Set up basic tools
sudo apt install curl wget git unzip snapd -y
# Step 1: Install Java
sudo apt install fontconfig openjdk-17-jre -y
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh
# Give user permissions to docker
sudo usermod -aG docker $USER
# Make a docker compose file for Jenkins
cat <<EOF > docker-compose.yml
version: '3.8'

services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    user: root
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - jenkins_data:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
    restart: unless-stopped

volumes:
  jenkins_data:
EOF

sudo chmod 666 /var/run/docker.sock

sg docker -c "docker compose up -d"
sleep 15

sg docker -c "docker exec -u root jenkins bash -c 'apt-get update && apt-get install -y docker.io'"

echo "Your initial Admin Password is:"
sg docker -c "docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword"


```
