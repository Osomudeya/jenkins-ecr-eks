pipeline {
    agent any
    
    environment {
        DOCKER_HUB_IMAGE = "osomudeya/docker-helloworld"
        ECR_REGISTRY = "public.ecr.aws/j7c0z4k6"
        ECR_REPOSITORY = "public.ecr.aws/j7c0z4k6"
        ECR_IMAGE_TAG = "latest"
    }

    stages {
        stage("Pull image from Docker Hub") {
            steps {
                sh "docker pull ${DOCKER_HUB_IMAGE}"
            }
        }

        stage("Tag image with ECR repository information") {
            steps {
                sh "docker tag ${DOCKER_HUB_IMAGE} ${ECR_REGISTRY}/${ECR_REPOSITORY}:${ECR_IMAGE_TAG}"
            }
        }

        stage('Push Image to ECR Repo') {
            steps {
                sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin "$ECR_REGISTRY"'
                sh 'docker push "$ECR_REGISTRY/$APP_REPO_NAME:latest"'
            }
        }
    }
    post {
        always {
            echo 'Deleting all local images'
            sh 'docker image prune -af'
        }
    }
}