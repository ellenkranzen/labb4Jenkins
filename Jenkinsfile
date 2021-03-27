pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ellenkranzen/labb4Jenkins.git'
            }
        }
        stage('Build') {
            steps {
                sh "mvn compile"
            }
        }
        stage('Test') {
            steps {
                sh "mvn test"
            }
            post {
                always {
                    junit '**/TEST*.xml'
                }
            }
        }
        stage('newman') {
            steps {
                sh 'newman run Restful_Booker.postman_collection.json --environment Restful_Booker.postman_environment.json --reporters junit'
            }
            post {
                always {
                    junit '**/*xml'
                }
            }
        }
        stage('CrossBrowserTesting') {
            steps {
                sh 'python ScreenShotCBT.py'
            }
        }
    }
}
