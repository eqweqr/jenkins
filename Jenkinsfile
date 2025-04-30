pipeline {
    agent any 
    environment {
        KEY=credentials('ssh_key') 
        USER=credentials('remote_user')
        IAMTOKEN=credentials('iamtoken')
        REGISTER=credentials('register')
        IMAGE="piper"
        TAG="latest"
    }
    stages {
        stage('Example stage 1') {
            steps {
                git 'https://github.com/eqweqr/jenkins'
                sh 'docker build -t ${REGISTER}/${IMAGE}:${TAG} .'
                sh 'echo ${IAMTOKEN} | docker login --username iam --password-stdin cr.yandex'
                sh 'docker push ${REGISTER}/${IMAGE}:${TAG}'
            }
        }
    }
}
