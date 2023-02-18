pipeline {
  agent any
  stages {
    stage ('Build') {
      steps {
        sh 'printenv'
        sh 'docker build -t docker-helloworld .'
      }
    }
    
  //  stage ('Publish to DockerHub') {
  //   steps {
  //     withDockerRegistry([credentialsId: "dockerhub-credentials", url: "https://index.docker.io/v1/"]) {
  //       sh 'docker push osomudeya/hello-my-name:""$GIT_COMMIT""'
  //      }
  //    }
  //  }

    stage ('Publish to ECR') {
      steps {
        withEnv(["AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID}", "AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY}", "AWS_DEFAULT_REGION=${env.AWS_DEFAULT_REGION}"]) {
          sh 'docker login -u AWS -p $(aws ecr-public get-login-password --region <your-region>) public.ecr.aws/j7c0z4k6'
          sh 'docker tag osomudeya/hello-my-name:latest public.ecr.aws/j7c0z4k6/hello-my-name:latest'
          sh 'docker push public.ecr.aws/j7c0z4k6/hello-my-name:latest'
         }
       }
    }
  }
}
