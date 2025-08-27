pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "yourdockerhubusername/devops-demo:${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/s566466div/devops-demo.git',
                    credentialsId: 'github-credentials' // Add your GitHub credentials ID
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'  // Change this if using Maven/Gradle
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test'     // Change this to your test command
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Build & Push Docker Image') {
        steps {
            script {
                dockerImage = docker.build("bathala/your-app:${BUILD_NUMBER}")
                
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials',
                                                usernameVariable: 'DOCKER_USER',
                                                passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push bathala/your-app:${BUILD_NUMBER}
                    '''
                }
            }
        }


    }

    post {
        always {
            cleanWs()
        }
    }
}
