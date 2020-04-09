pipeline {
    environment {
        registryCredential = 'dockerhub'
        repository = 'hupe1980/udacity-devops-capstone-frontend'
        cluster = 'k8s-cluster'
    }
    agent any
    stages {
        stage('Lint Html') {
            steps {
                sh 'tidy -q -e frontend/src/*.html'
            }
        }
        stage ("Lint Dockerfile") {
            agent {
                docker {
                    image 'hadolint/hadolint:latest-debian'
                }
            }
            steps {
                sh 'hadolint frontend/* | tee -a hadolint_lint.txt'
            }
            post {
                always {
                    archiveArtifacts 'hadolint_lint.txt'
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build("${repository}:${env.GIT_COMMIT[0..7]}", "./frontend")
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'eu-central-1') {
                    sh "aws eks --region eu-central-1 update-kubeconfig --name ${cluster}"
                    sh "kubectl set image deployment/frontend frontend=${repository}:${env.GIT_COMMIT[0..7]}"
                }
            }
        }
    }
}