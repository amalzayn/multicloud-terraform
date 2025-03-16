pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/bin:/opt/homebrew/bin/terraform:/usr/local/bin:/usr/bin:/bin:$PATH"  // Include paths for both Terraform and gcloud
        GCP_KEY_FILE = "/Users/ftzayn/Desktop/multi-cloud1/learn-terraform-multicloud-kubernetes/gke/terraform-key.json"
    }
    stages {
        stage('Setup') {
            steps {
                script {
                    echo "Running Pipeline on Jenkins Node"
                    sh 'whoami'
                    
                    // Check for required tools
                    sh '''
                        echo "Checking for required tools..."
                        which terraform || echo "Terraform not found"
                        which gcloud || echo "gcloud not found"
                    '''
                    
                    // Install gcloud if not available
                    sh '''
                        if ! command -v gcloud &> /dev/null; then
                            echo "Installing Google Cloud SDK..."
                            # For macOS
                            if [[ "$(uname)" == "Darwin" ]]; then
                                brew install --cask google-cloud-sdk || echo "Failed to install via Homebrew, consider manual installation"
                            else
                                echo "Please install Google Cloud SDK manually on this platform"
                                exit 1
                            fi
                        fi
                    '''
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
                        export GOOGLE_APPLICATION_CREDENTIALS="$GCP_KEY_FILE"
                        echo "Authenticating with GCP..."
                        gcloud auth activate-service-account --key-file="$GOOGLE_APPLICATION_CREDENTIALS"
                        echo "Initializing Terraform..."
                        terraform init
                        echo "Applying Terraform changes..."
                        terraform apply -auto-approve
                    '''
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed'
        }
        success {
            echo 'Pipeline executed successfully'
        }
        failure {
            echo 'Pipeline execution failed'
        }
    }
}
