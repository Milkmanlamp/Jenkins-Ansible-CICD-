## Docker + docker hub
## Set up the apt repo
``` bash
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
```

## install docker packages
``` bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## assign permissions and apply to current session
``` bash
sudo usermod -aG docker $USER
```
``` bash
newgrp docker
```

## Docker + local repo
``` bash
docker run -d -p 5000:5000 --restart=always --name local-registry registry:2

```

## Tag your image so it sends to the local registry
``` bash
docker tag alpine localhost:5000/my-custom-alpine
```

## push to local registry
``` bash
docker push localhost:5000/my-custom-alpine
```

## Delete as its now in the registry
``` bash
docker rmi localhost:5000/my-custom-alpine
docker rmi alpine
```

## pulling
``` bash
docker pull localhost:5000/my-custom-alpine
```


# Building container
Docker will build the dockerfile in the current directory
``` bash
docker build . or path
```

## tagging while building 
as when you build an image it will give it a unreadable id and its hard to use
``` bash
docker build -t my-app
```


# Kubeernetes
no docker needed as it uses containerd backed in
## set up microk8s (need Snap)
``` bash
sudo snap install microk8s --classic
```
classic gives perms for deep hardware access

## Give permissions for microk8s
``` bash
sudo usermod -aG microk8s $USER
newgrp microk8s
```

## Change folder owner 
``` bash
sudo chown -f -R $USER ~/.kube
```

## setup dns and hostpath-storage
you need this to for your containers to alk via dns and also to save files locally
``` bash
microk8s enable dns
microk8s enable hostpath-storage
```

## set up alias
``` bash 
echo 'alias kubectl="mircok8s kubectl"' >> ~/.bashrc
source ~/.bashrc
```