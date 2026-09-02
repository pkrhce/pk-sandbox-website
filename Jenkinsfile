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
                sh "kubectl apply -f deployment.yaml"
                sh "kubectl apply -f service.yaml"
                // This forces K8s to pull the newest image we just built
                sh "kubectl rollout restart deployment/website-deployment"
            }
        }
    }
}
