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
          sh '''
            echo "your-password" | docker login -u AWS --password-stdin public.ecr.aws/j7c0z4k6
            docker build -t docker-helloworld .
            docker tag docker-helloworld:latest public.ecr.aws/j7c0z4k6/docker-helloworld:"${BUILD_ID}"
            docker push public.ecr.aws/j7c0z4k6/docker-helloworld:latest:"${BUILD_ID}"
          '''
        }
      }
    }
  }
}
