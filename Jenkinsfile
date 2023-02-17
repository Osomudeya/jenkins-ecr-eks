pipeline {
  agent any
  environment {
    AWS_ACCOUNT_ID="public.ecr.aws/j7c0z4k6"
    AWS_DEFAULT_REGION="us-east-1"
    IMAGE_REPO_NAME="docker-helloworld"
    IMAGE_TAG="latest"
    REPOSITORY_URI = "public.ecr.aws/j7c0z4k6/docker-helloworld:${IMAGE_TAG}"
  }

  stages {
    stage('Logging into AWS ECR') {
      steps {
        script {
          sh """aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/j7c0z4k6"""
        }
      }
    }

    stage('Cloning Git') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/Osomudeya/jenkins-ecr-eks.git']]])
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