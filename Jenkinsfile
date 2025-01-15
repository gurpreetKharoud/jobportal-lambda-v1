pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPOSITORY = 'jobportal/jobportal-lambda'
        IMAGE_NAME = "816069138092.dkr.ecr.us-east-1.amazonaws.com/jobportal/jobportal-lambda"
        COMMIT_HASH = sh(script: 'echo $(echo $GIT_COMMIT | cut -c 1-7)', , returnStdout: true).trim()
        IMAGE_TAG = 'latest'
        LAMBDA_FUNCTION_NAME = 'jobportal-docker-test'
    }
    tools {
        jdk 'JDK 17'
        maven 'Maven 3.8.8'
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Application') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Push') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${COMMIT_HASH} .'
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 816069138092.dkr.ecr.us-east-1.amazonaws.com'
                //sh 'docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 816069138092.dkr.ecr.us-east-1.amazonaws.com'
            	sh 'docker tag $REPOSITORY_URI:latest $REPOSITORY_URI:$COMMIT_HASH'
		        sh 'docker push $REPOSITORY_URI:latest'
		        sh 'docker push $REPOSITORY_URI:$COMMIT_HASH'
            }
        }

        stage('Update Lambda Function') {
            steps {
                sh '''
                aws lambda update-function-code --function-name ${LAMBDA_FUNCTION_NAME} \
                --image-uri ${IMAGE_NAME}:${COMMIT_HASH}
                '''
            }
        }
    }
    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check logs.'
        }
    }
}
