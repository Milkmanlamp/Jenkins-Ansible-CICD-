pipeline {
    agent any

    stages {
        stage('Deploy to Web Server') {
            steps {
                sh '''
                    mkdir -p /tmp/my-website
                    cp -R $WORKSPACE/* /tmp/my-website/
                    
                    # THIS IS THE MISSING LINE
                    chmod -R 755 /tmp/my-website/
                    
                    docker stop my-website || true
                    docker rm my-website || true
                    docker run -d --name my-website -p 80:80 -v /tmp/my-website:/usr/share/nginx/html nginx:latest
                '''
            }
        }
    }
}
