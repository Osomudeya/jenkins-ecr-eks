pipeline {
    agent any
    
    environment {
        // Define environment variables 
        DOCKER_IMAGE_NAME = 'osomudeya/docker-helloworld'
        DOCKER_HUB_REPO = 'osomudeya'
        DOCKER_HUB_TAG = 'latest'
        AWS_REGION = 'us-east-1'
        AWS_ECR_REPO = 'docker-helloworld'
        AWS_ACCOUNT_ID = sh(returnStdout: true, script: 'aws sts get-caller-identity --query Account --output text').trim()
    //   AWS_ACCOUNT_ID = "public.ecr.aws/j7c0z4k6"
    }
    
    stages {
        stage('Pull from Docker Hub') {
            steps {
                // Pull the Docker image from Docker Hub
                sh "docker pull ${DOCKER_HUB_REPO}/${DOCKER_IMAGE_NAME}:${DOCKER_HUB_TAG}"
            }
        }
        
        stage('Tag and Push to ECR') {
            steps {
                // Tag the Docker image with the ECR repository URL
                sh "docker tag ${DOCKER_HUB_REPO}/${DOCKER_IMAGE_NAME}:${DOCKER_HUB_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${AWS_ECR_REPO}:${DOCKER_HUB_TAG}"
                
                // Login to the Amazon ECR repository
                sh "aws ecr get-login-password | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
                
                // Push the Docker image to the Amazon ECR repository
                sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${AWS_ECR_REPO}:${DOCKER_HUB_TAG}"
            }
        }
    }
}
