pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'printenv'
      }
    }
    stage('Publish ECR') {
      steps {
        withEnv([
          "AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID}",
          "AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY}",
          "AWS_DEFAULT_REGION=${env.AWS_DEFAULT_REGION}"
        ]) {
          sh 'docker login -u AWS -p $(aws ecr-public get-login-password --region us-east-1) public.ecr.aws/j7c0z4k6'
          sh 'docker build -t docker-helloworld .'
          sh 'docker tag docker-helloworld:latest "${BUILD_ID}"'
          sh 'docker push public.ecr.aws/j7c0z4k6/docker-helloworld:"${BUILD_ID}"'
        }
      }
    }
  }
}
