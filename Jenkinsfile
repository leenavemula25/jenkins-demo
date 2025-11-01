pipeline {
    agent any

    environment {
        APP_NAME = "myapp"
        DEPLOY_USER = "ec2-user"
        DEPLOY_HOST = "your.server.ip"
        DEPLOY_DIR = "/var/www/myapp"
        SERVICE_SCRIPT = "/var/www/myapp/restart.sh"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Checking out code..."
                git branch: 'main', url: 'https://github.com/yourusername/yourrepo.git'
            }
        }

        stage('Build App') {
            steps {
                echo "Building the application..."
                sh '''
                # Example for Node.js app
                npm install
                npm run build
                # For Python app, use:
                # pip install -r requirements.txt
                '''
            }
        }

        stage('Deploy to Server') {
            steps {
                echo "Deploying to target server..."
                sshagent(['my-ssh-credentials']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no $DEPLOY_USER@$DEPLOY_HOST << EOF
                        echo "Cleaning old code..."
                        rm -rf $DEPLOY_DIR/*
                        mkdir -p $DEPLOY_DIR
                        exit
                    EOF

                    echo "Copying new build..."
                    scp -o StrictHostKeyChecking=no -r * $DEPLOY_USER@$DEPLOY_HOST:$DEPLOY_DIR/

                    echo "Restarting service..."
                    ssh -o StrictHostKeyChecking=no $DEPLOY_USER@$DEPLOY_HOST "bash $SERVICE_SCRIPT"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Build and deployment successful!"
            mail to: 'team@example.com',
                 subject: "SUCCESS: ${env.JOB_NAME} Build #${env.BUILD_NUMBER}",
                 body: "Good news! The build and deployment completed successfully."
        }
        failure {
            echo "Build or deployment failed!"
            mail to: 'team@example.com',
                 subject: "FAILED: ${env.JOB_NAME} Build #${env.BUILD_NUMBER}",
                 body: "Unfortunately, the build or deployment failed. Check Jenkins logs for details."
        }
    }
}
