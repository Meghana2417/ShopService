pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = 'docker-hub-creds'
    DOCKERHUB_USER = 'meghana1724'     // change to your DockerHub username
    IMAGE_NAME = "${DOCKERHUB_USER}/shopservice"
   SSH_CRED_ID = 'deploy-ssh-key' 
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
        }
      }
    }

    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
          sh """
          echo $PASS | docker login -u $USER --password-stdin
          docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest
          docker push ${IMAGE_NAME}:${BUILD_NUMBER}
          docker push ${IMAGE_NAME}:latest
          docker logout
          """
        }
      }
    }

    stage('Deploy to Production') {
      steps {
        sshagent (credentials: ['ec2-prod-server']) {
          sh """
          ssh -o StrictHostKeyChecking=no ubuntu@13.235.90.226 '
            docker login -u ${DOCKERHUB_USER} -p ${PASS}
            cd /home/ubuntu/deployments/shopservice &&
            docker-compose -f docker-compose.prod.yml pull &&
            docker-compose -f docker-compose.prod.yml up -d
          '
          """
        }
      }
    }
  }

  post {
    success {
      echo "✅ ShopService deployed successfully."
    }
    failure {
      echo "❌ Deployment failed."
    }
  }
}
