

pipeline {
    agent any
    environment {
      
      //  REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"


    }
   
    stages {
        
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/j7c0z4k6"
                }
                 
            }
        }
        stage('Build the Docker Image') {
              steps {
                  script {
                  sh "docker build -t docker-helloworld .."
                  }
              }
        }
        stage('Push the Docker Image to the ECR') {
              steps {
                  script {
                  sh "docker tag docker-helloworld:latest public.ecr.aws/j7c0z4k6/docker-helloworld:latest"
                  sh "docker push public.ecr.aws/j7c0z4k6/docker-helloworld:latest"
                  }
              }
        }
        stage('Deploy in the ECS') {
              steps {
                  script {
                  sh "aws ecs update-service --cluster sundar-ecs-cluster --service nodeapp-svc  --force-new-deployment --region ${AWS_DEFAULT_REGION}"
                  }
              }
        }
        
  
   
    }
}