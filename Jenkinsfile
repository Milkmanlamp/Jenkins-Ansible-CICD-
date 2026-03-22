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
