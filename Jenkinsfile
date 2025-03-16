pipeline {
    agent any

    environment {
        PATH = "/opt/homebrew/bin/terraform:$PATH"  // Ensure Terraform is in PATH
        GCP_KEY_FILE = "/Users/ftzayn/Desktop/multi-cloud1/learn-terraform-multicloud-kubernetes/gke/terraform-key.json"
    }

    stages {
        stage('Setup') {
            steps {
                script {
                    echo "Running Pipeline on Jenkins Node"
                    sh 'whoami'
                }
            }
        }

        stage('Use Local Repo') {
            steps {
                script {
                    def localRepo = "/Users/ftzayn/Desktop/multi-cloud1/learn-terraform-multicloud-kubernetes/gke"
                    if (!fileExists(localRepo)) {
                        error "Local repository not found: ${localRepo}"
                    }
                    echo "Using local repo at ${localRepo}"
                }
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                dir('/Users/ftzayn/Desktop/multi-cloud1/learn-terraform-multicloud-kubernetes/gke') {
                    script {
                        if (!fileExists(env.GCP_KEY_FILE)) {
                            error "GCP service account key file not found: ${env.GCP_KEY_FILE}"
                        }
                    }
                    
                    sh '''
                        export GOOGLE_APPLICATION_CREDENTIALS=$GCP_KEY_FILE
                        echo "Authenticating with GCP..."
                        gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS

                        echo "Initializing Terraform..."
                        terraform init

                        echo "Applying Terraform changes..."
                        terraform apply -auto-approve
                    '''
                }
            }
        }
    }
}
