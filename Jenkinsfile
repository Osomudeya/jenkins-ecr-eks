pipeline {
  agent any
  
  environment {
    DOCKER_HUB_IMAGE = 'osomudeya/docker-helloworld'
    ECR_REGISTRY = 'public.ecr.aws/j7c0z4k6'
    ECR_REPOSITORY = 'docker-helloworld'
    AWS_REGION = 'us-east-1'
  }
  
  stages {
    stage('Pull from Docker Hub') {
      steps {
        script {
          // Authenticate with Docker Hub
          docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
            // Pull the image from Docker Hub
            docker.image("${env.DOCKER_HUB_IMAGE}").pull()
          }
        }
      }
    }
    
    stage('Push to ECR') {
      steps {
        script {
          // Authenticate with AWS ECR
          withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh "aws ecr get-login-password --region ${env.AWS_REGION} | docker login --username AWS --password-stdin ${env.ECR_REGISTRY}"
          }
          
          // Tag the Docker image for ECR
          def ecrImage = "${env.ECR_REGISTRY}/${env.ECR_REPOSITORY}:${env.BUILD_NUMBER}"
          docker.image("${env.DOCKER_HUB_IMAGE}").tag(ecrImage)
          
          // Push the Docker image to ECR
          docker.withRegistry("${env.ECR_REGISTRY}", 'ecr-credentials') {
            docker.image(ecrImage).push()
          }
        }
      }
    }
  }
}
