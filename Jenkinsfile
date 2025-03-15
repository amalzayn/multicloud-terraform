pipeline {
    agent any

    environment {
        GOOGLE_CREDENTIALS = credentials('GCP_CREDENTIALS')
        PROJECT_ID = 'your-gcp-project-id'
        REGION = 'us-east1'
        CLUSTER_NAME = 'gke-cluster'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/your-repo.git'
            }
        }

        stage('Authenticate with GCP') {
            steps {
                sh 'echo $GOOGLE_CREDENTIALS > /tmp/gcp-key.json'
                sh 'gcloud auth activate-service-account --key-file=/tmp/gcp-key.json'
                sh 'gcloud config set project $PROJECT_ID'
            }
        }

        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Plan Terraform') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Apply Terraform') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }

    post {
        always {
            sh 'rm -f /tmp/gcp-key.json'
        }
    }
}
