pipeline {
    agent any

    stages {
        stage('Deploy to Web Server') {
            steps {
                sh '''
                    # 1. Stop and remove the old website
                    docker stop my-website || true
                    docker rm my-website || true
                    
                    # 2. Start a fresh, empty Nginx web server (Notice we removed the -v volume)
                    docker run -d --name my-website -p 80:80 nginx:latest
                    
                    # 3. Copy all website files directly from Jenkins into the live Nginx container
                    docker cp $WORKSPACE/. my-website:/usr/share/nginx/html/
                '''
            }
        }
    }
}
