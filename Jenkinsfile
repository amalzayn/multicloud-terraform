pipeline {
    agent any  

    environment {
        GCP_SERVICE_ACCOUNT = credentials('gcp-json-key') // Use Jenkins credential store
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/amalzayn/multicloud-terraform.git'
            }
        }

        stage('Initialize Terraform') {
            steps {
                script {
                    sh '''
                        cd gke
                       /usr/local/bin/terraform init
                    '''
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                script {
                    sh '''
                        cd gke
                       /usr/local/bin/terraform plan -out=tfplan
                    '''
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                script {
                    sh '''
                        cd gke
                        /usr/local/bin/terraform apply -auto-approve tfplan
                    '''
                }
            }
        }
    }
}
