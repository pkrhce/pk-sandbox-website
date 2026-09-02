pipeline {
    agent any
    
    environment {
        PROJECT_ID = 'pk-sandbox-507311'
        REGION = 'us-central1'
        REPO_NAME = 'website-repo'
        IMAGE_NAME = 'pk-website'
        // This creates a unique tag for every build (e.g., v1, v2)
        IMAGE_TAG = "v${env.BUILD_ID}" 
        // The full path to your Google Artifact Registry
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
    }
}
