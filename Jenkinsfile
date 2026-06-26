pipeline{
    agent any

    environment{
        IMAGE_NAME= "todo-application-image"
        DOCKERHUB_USERNAME= "shamimalam320"
    }

    stages{

        stage('Clone'){
            steps{
                checkout scm
            }
        }

        stage('Build Maven'){
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build'){
            steps {
                sh 'docker build -t todo-application-image:latest .'
            }
        }

        stage('Docker login'){
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credential', usernameVariable: 'USER',passwordVariable: 'PASS')]){
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                }
            }
        }

        stage('Tag'){
            steps {
                sh 'docker tag todo-application-image:latest shamimalam320/todo-application:latest'
            }
        }

        stage ('Push'){
            steps{
                sh 'docker push shamimalam320/todo-application:latest'
            }
        }

        stage('Deploy'){
            steps {
                sh 'docker compose up -d'
            }
        }
    }
    post{
        always{
         sh 'rm -rf *'
        }
    }    

}
