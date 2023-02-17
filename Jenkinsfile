pipeline {
  agent any
  environment {
    AWS_ACCOUNT_ID="public.ecr.aws/j7c0z4k6"
    AWS_DEFAULT_REGION="us-east-1"
    IMAGE_REPO_NAME="docker-helloworld"
    IMAGE_TAG="v1"
    REPOSITORY_URI = "public.ecr.aws/j7c0z4k6/docker-helloworld:${IMAGE_TAG}"
  }

  stages {
    stage('Logging into AWS ECR') {
      steps {
        script {
          sh """aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"""
        }
      }
    }

    stage('Cloning Git') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'YOUR_CREDENTIALS_ID_HERE', url: 'https://github.com/Osomudeya/jenkins-ecr-eks.git']]])
      }
    }

    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }

    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
      steps{
        script {
          sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}"""
          sh """docker push ${REPOSITORY_URI}"""
        }
      }
    }
  }
}