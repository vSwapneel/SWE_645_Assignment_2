pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-cred') // Docker credentials added to Jenkins and names the set as docker-pass
    }
    stages {
        stage('Initialize') {
            steps {
                script {
                    // Defining a build timestamp variable
                    env.BUILD_TIMESTAMP = new Date().format("yyyyMMddHHmmss", TimeZone.getTimeZone('UTC'))
                    echo "Build timestamp: ${env.BUILD_TIMESTAMP}"
                }
            }
        }


        stage('Building the Student Survey Image') {
            steps {
                script {
                    
                    // Securely handling Docker login
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', 
                                                      usernameVariable: 'DOCKER_USER', 
                                                      passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                            echo "\$DOCKER_PASS" | docker login -u "\$DOCKER_USER" --password-stdin
                        """
                    }

                    // Building Docker image using the BUILD_TIMESTAMP
                    def imageName = "vswapneel/assignment2:${env.BUILD_TIMESTAMP}"
                    sh "docker build -t ${imageName} ."

                    // Saving image name for later stages
                    env.IMAGE_NAME = imageName
                }
            }
        }
        

        stage('Pushing Image to DockerHub') {
            steps {
                script {
                    // Pushing the Docker image to DockerHub
                    sh "docker push ${env.IMAGE_NAME}"
                }
            }
        }

        stage('Deploying to Rancher') {
            steps {
                script {
                    // Deploying the new image to Rancher
                    sh "kubectl set image deployment/hw2-deployment container-0=${env.IMAGE_NAME}"
                }
            }
        }
    }
}
