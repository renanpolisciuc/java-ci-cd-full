def docker_image_my_app
def version

pipeline {
    agent any

    stages {
        stage('Get version') {
            steps {
                script {
                    version = sh(script: 'git rev-parse --short=7 HEAD', returnStdout: true)
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    docker_image_my_app = docker.build("rpolisciuc/my-app")
                }
            }
        }
        stage('Push') {
            steps {
                echo 'Push to dockerhub....'
                script {
                    docker.withRegistry("", "docker-hub-credentials") {
                        docker_image_my_app.push(version)
                    }
                }
            }
        }
    }
}
