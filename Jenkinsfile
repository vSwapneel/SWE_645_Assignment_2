pipeline {
    agent any
    parameters {
        string(name: 'NAMESPACE', defaultValue: 'default', description: 'Kubernetes Namespace')
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("vswapneel/assignment2:${env.BUILD_ID}")
                    // Push the image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        docker.image("vswapneel/assignment2:${env.BUILD_ID}").push()
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Apply the deployment and service YAML files
                    sh 'kubectl apply -f deployment.yaml -n ${params.NAMESPACE} || { echo "Deployment failed"; exit 1; }'
                    sh 'kubectl apply -f service.yaml -n ${params.NAMESPACE} || { echo "Service creation failed"; exit 1; }'
                }
            }
        }
    }
}
