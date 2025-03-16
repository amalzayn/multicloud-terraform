pipeline {
    agent any

    environment {
        PROJECT_ID = 'symbolic-math-446906-f2'
        REGION = 'us-central1'
        CLUSTER_NAME = 'test-cluster'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Authenticate to GCP') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh '''
                         gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
                         gcloud config set project $PROJECT_ID
                    '''

                }
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh """
                        export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS
                        terraform init
                        terraform plan -out=tfplan
                    """
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh """
                        export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS
                        terraform apply -auto-approve tfplan
                    """
                }
            }
        }

        stage('Configure Kubectl for GKE') {
            steps {
                sh """
                    gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION --project $PROJECT_ID
                    kubectl get nodes
                """
            }
        }
    }
}
