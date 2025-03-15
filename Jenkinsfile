pipeline {
    agent any  

    environment {
        GCP_SERVICE_ACCOUNT = credentials('gcp-json-key') // Use Jenkins credential store
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/amalzayn/mulitcloud-terraform/terraform-gke.git'
            }
        }

        stage('Initialize Terraform') {
            steps {
                script {
                    sh '''
                        cd terraform-gke
                        terraform init
                    '''
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                script {
                    sh '''
                        cd terraform-gke
                        terraform plan -out=tfplan
                    '''
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                script {
                    sh '''
                        cd terraform-gke
                        terraform apply -auto-approve tfplan
                    '''
                }
            }
        }
    }
}
