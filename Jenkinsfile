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
        DOCKER_USER = "ensadevsecops"
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
       stage("Build & Push Docker Image") {
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }

        }
        stage("Trivy Scan") {
             steps {
                 script {
		              sh ('trivy image ensadevsecops/ensa-social-media-app:latest --no-progress --scanners vuln  --exit-code 0 --severity HIGH,CRITICAL --format table')
                }
            }

        }
        stage("Email Notification"){
            steps {
                mail to : 'prvamine2@gmail.com',
		     subject : 'Trivy scan completed for the lastet image docker build',
		     body : 'Check Jenkins UI to see detailed results'
            }
         
            
        }
	stage("Trigger CD Pipeline") {
            steps {
                script {
                    //sh "curl -v -k --user admin:${JENKINS_API_TOKEN} -X POST -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' --data 'IMAGE_TAG=${IMAGE_TAG}' 'https://jenkins.dev.dman.cloud/job/gitops-complete-pipeline/buildWithParameters?token=gitops-token'"
		      sh "echo 'deployement successfull of ensa app'"
                }
            }

        }

    }
        
        
    }
        
