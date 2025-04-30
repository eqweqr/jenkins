pipeline {
    agent any 
    environment {
        KEY=credentials('rsa') 
        USER=credentials('remote_user')
        IAMTOKEN=credentials('iamtoken')
        REGISTER=credentials('register')
        IMAGE="piper"
        TAG="latest"
        CONTAINER="predprod"
        IP=credentials('ip')
    }
    stages {
        stage('Build') {
            steps {
                git 'https://github.com/eqweqr/jenkins'
                sh 'docker build -t ${REGISTER}/${IMAGE}:${TAG} .'
            }
        }

        stage('Delivery'){
            steps{
                sh 'echo ${IAMTOKEN} | docker login --username iam --password-stdin cr.yandex'
                sh 'docker push ${REGISTER}/${IMAGE}:${TAG}'
            }
        }

        stage('Deploy'){
            steps{
		sh 'cp /tmp/id_rsa ${KEY}'
                sh 'chmod 600 /tmp/id_rsa'
                sh """
                ssh -i /tmp/id_rsa -l ${USER} ${IP} 'docker pull ${REGISTER}/${IMAGE}:${TAG} && docker stop ${CONTAINER} || true  && docker rm ${CONTAINER} || true && docker run --name ${CONTAINER} -d ${REGISTER}/${IMAGE}:${TAG} '
                """
            }
        }
    }
}
