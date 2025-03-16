pipeline {
    agent any

    environment {
        PROJECT_ID = 'symbolic-math-446906-f2'
        REGION = 'us-central1'
        CLUSTER_NAME = 'test01-cluster'
        LOCAL_REPO = '/Users/ftzayn/Desktop/multi-cloud1/learn-terraform-multicloud-kubernetes/gke'  // Change to your actual path
    }

    stages {
        stage('Use Local Repo') {
            steps {
                script {
                    if (!fileExists(env.LOCAL_REPO)) {
                        error "Local repo path not found: ${env.LOCAL_REPO}"
                    }
                }
                dir(env.LOCAL_REPO) {
                    sh 'ls -l'  // Debugging: List files in the local repo
                }
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                dir(env.LOCAL_REPO) {
                    withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                        sh '''
                            export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS
                            terraform init
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }
    }
}
