pipeline{
    agent{
        label "jenkins-agent"
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    environment {
        APP_NAME = "ensa-social-media-app"
        RELEASE = "1.0.0"
        DOCKER_USER = "ENSAdevsecops"
        DOCKER_PASS = 'dockerhub'
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
        

    }
    stages{
        stage("Cleanup Workspace"){
            steps {
                cleanWs()
            }
         
            
        }
        
        stage("Checkout from SCM"){
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/GCDSTE/devsecops-project'
         
            }
        }
        stage("Build Application"){
            steps {
                sh "mvn clean install -U"
            }

        }
        stage("Test Application"){
            steps {
                sh "mvn  test"
            }

        }
        stage("Sonarqube Analysis") {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token') {
                        sh "mvn sonar:sonar"
                    }
                }
            }

        }
        
    }
        
}
