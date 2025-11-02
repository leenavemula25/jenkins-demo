pipeline {
    agent any

    tools {
        nodejs 'node18'   // Must match the name in Manage Jenkins → Tools
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code...'
            }
        }

        stage('Build App') {
            steps {
                echo "Installing dependencies..."
                sh 'npm install'
            }
        }

        stage('Deploy Locally') {
            steps {
                echo 'Starting the app...'
                sh 'bash restart.sh'
            }
        }
    }

    post {
        success {
            echo 'Build and deployment successful!'
        }
        failure {
            echo 'Build or deployment failed!'
        }
    }
}
