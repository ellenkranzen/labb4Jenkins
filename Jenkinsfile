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
        stage('Robot Framework System tests with Selenium') {
            steps {
                sh 'robot --variable BROWSER:headlesschrome -d Results  Tests'
            }
            post {
                always {
                    script {
                          step(
                                [
                                  $class              : 'RobotPublisher',
                                  outputPath          : 'Results',
                                  outputFileName      : '**/output.xml',
                                  reportFileName      : '**/report.html',
                                  logFileName         : '**/log.html',
                                  disableArchiveOutput: false,
                                  passThreshold       : 50,
                                  unstableThreshold   : 40,
                                  otherFiles          : "**/*.png,**/*.jpg",
                                ]
                          )
                    }
                }
            }
        }
        stage('CrossBrowserTesting') {
            steps {
                sh 'curl --user ellen.kranzen@iths.se:u2578f8afad30827 --data "browser=Mac10.11|Safari9|1024x768&browsers=Win10|Edge20|800x600&url=http://www.google.com" https://crossbrowsertesting.com/api/v3/screenshots/'
            }
        }
    }
}
