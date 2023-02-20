pipeline {
    agent any
    environment {
        registry = "public.ecr.aws/j7c0z4k6/docker-helloworld"
    }
    stages {
        stage('Cloning Git') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/master']],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [],
                    submoduleCfg: [],
                    userRemoteConfigs: [[credentialsId: '<git-credentials-id>', url: 'https://github.com/Osomudeya/jenkins-ecr-eks.git']]
                ])
            }
        }
        stage('Building image') {
            steps {
                script {
                    docker.build(registry)
                }
            }
        }
        stage('Pushing to ECR') {
            steps {  
                script {
                    sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/j7c0z4k6'
                    sh 'docker push public.ecr.aws/j7c0z4k6/docker-helloworld:latest'
                }
            }
        }
        stage('K8S Deploy') {
            steps {   
                script {
                    withKubeConfig([credentialsId: 'K8S', serverUrl: '<k8s-server-url>']) {
                        sh 'curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl'
                        sh 'chmod +x kubectl'
                        sh 'sudo mv kubectl /usr/local/bin'
                        sh 'kubectl apply -f deployment.yaml'
                    }
                }    
            }
        }
    }
}
