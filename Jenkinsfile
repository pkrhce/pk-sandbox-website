pipeline {
    agent any
    
    environment {
        PROJECT_ID = 'pk-sandbox-507311'
        REGION = 'us-central1'
        REPO_NAME = 'website-repo'
        IMAGE_NAME = 'pk-website'
        IMAGE_TAG = "v${env.BUILD_ID}" 
        GAR_PATH = "${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo "Building Docker Image..."
                sh "docker build -t ${GAR_PATH}:${IMAGE_TAG} -t ${GAR_PATH}:latest ."
            }
        }
        
        stage('Push to Artifact Registry') {
            steps {
                echo "Pushing Image to GAR..."
                sh "docker push ${GAR_PATH}:${IMAGE_TAG}"
                sh "docker push ${GAR_PATH}:latest"
            }
        }
        
        stage('Deploy to GKE') {
            steps {
                echo "Deploying to Kubernetes..."
                sh "/usr/bin/kubectl apply -f deployment.yaml"
                sh "/usr/bin/kubectl apply -f service.yaml"
                sh "/usr/bin/kubectl rollout restart deployment/website-deployment"
            }
        }
    }
}
