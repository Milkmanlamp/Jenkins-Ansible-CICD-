pipeline {
    agent any

    stages {
        stage('Deploy to Web Server') {
            steps {
                sh '''
                    # 1. Stop and remove the old website
                    docker stop my-website || true
                    docker rm my-website || true
<<<<<<< HEAD

                    # 2. Start a fresh, empty Nginx web server (Notice we removed the -v volume)
                    docker run -d --name my-website -p 80:80 nginx:latest

=======
                    
                    # 2. Start a fresh, empty Nginx web server (Notice we removed the -v volume)
                    docker run -d --name my-website -p 80:80 nginx:latest
                    
>>>>>>> 3fc77e4231c9bee501f55d960e80e10d7a82cba2
                    # 3. Copy all website files directly from Jenkins into the live Nginx container
                    docker cp $WORKSPACE/. my-website:/usr/share/nginx/html/
                '''
            }
        }
    }
}
