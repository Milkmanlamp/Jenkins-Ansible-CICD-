# Jenkins-Ansible-CICD-

## Interview Prep Project

In this project, I want to get some experience with some new tech so I can understand what the interviewer is saying when I ask questions about the job.

## The Flow
So for this project, I would like to simulate the flow that might be used at the company I'm applying for.

1. The devs will update the company's application on Bitbucket.
2. The Jenkins VM will be polling Bitbucket for new merges.
3. When a merge is made, Jenkins will download the new code, build a Docker image based off it.
4. Once that file is saved, it will be securely sent to a container via SCP. Then, Jenkins will SSH in and run a script to load the image (`docker load`).

## The Tech Used
At the moment I have a rough idea of what I want to build. Below is the tech that I want to use:

*   **Terraform** - for the setup of the AWS EC2 instances and network security. ----------- not using anymore ran out of time, i might later
*   **Ansible** - for the configuration setup of the VM and later the website container.
*   **Bash** - for the initial jenkins set up script for running in a container.
*   **AWS** - for the networking and VMs (simulating their on-prem server room). -------- ran out of time, using a debian Linux vm to host the containers 
*   **Jenkins** - for the CI/CD pipeline for the devs' hosted app.
*   **Bitbucket** - for the repo that will be monitored by Jenkins. ---------- moved to git, ran out of time
*   **Docker & Kubernetes (Minikube)** - for containerising the app and running it on the target VM.----------- not using anymore ran out of time, i might later

## Goals 

*   Understand the basics of Jenkins + Bitbucket.
*   Understand the basics of Ansible.
