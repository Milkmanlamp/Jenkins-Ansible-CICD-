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
