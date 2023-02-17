pipeline {
  agent any

  environment {
    DOCKERHUB_REGISTRY = "osomudeya"
    DOCKERHUB_USERNAME = credentials("dockerhub-credentials").username
    DOCKERHUB_PASSWORD = credentials("dockerhub-credentials").password
    AWS_ACCESS_KEY_ID = credentials("aws-credentials").accessKeyId
    AWS_SECRET_ACCESS_KEY = credentials("aws-credentials").secretAccessKey
    AWS_DEFAULT_REGION = "us-east-1"
    ECR_REGISTRY = "public.ecr.aws/j7c0z4k6"
  }

  stages {
    stage('Pull Docker image') {
      steps {
        sh "sudo docker login --username ${DOCKERHUB_USERNAME} --password ${DOCKERHUB_PASSWORD} ${DOCKERHUB_REGISTRY}"
        sh "sudo docker pull ${DOCKERHUB_REGISTRY}/docker-helloworld:latest"
      }
    }

    stage('Push to ECR') {
      steps {
        withCredentials([string(credentialsId: 'aws-credentials', variable: 'AWS_ACCESS_KEY_ID'),
                          string(credentialsId: 'aws-credentials', variable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh "aws ecr-public get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}"
          sh "docker tag ${DOCKERHUB_REGISTRY}/docker-helloworld:latest ${ECR_REGISTRY}/docker-helloworld:latest"
          sh "docker push ${ECR_REGISTRY}/docker-helloworld:latest"
        }
      }
    }
  }
}
