pipeline {
    agent any

    environment {
        DOCKER_CREDS = credentials('docker-hub')
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/Meghana2417/ShopService.git'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build --no-cache -t meghana1724/shopservice:latest ."
            }
        }

        stage('Docker Login') {
            steps {
                sh 'echo "$DOCKER_CREDS_PSW" | docker login -u "$DOCKER_CREDS_USR" --password-stdin'
            }
        }

        stage('Docker Push') {
            steps {
                sh "docker push meghana1724/shopservice:latest"
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker stop shopservice || true
                docker rm shopservice || true

                docker pull meghana1724/shopservice:latest

                docker run -d --name shopservice -p 8002:8002 meghana1724/shopservice:latest
                '''
            }
        }
    }
}
