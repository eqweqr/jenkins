pipeline {
    agent any 
    environment {
        IAMTOKEN=credentials('iamtoken')
        REGISTER=credentials('register')
        IMAGE="piper"
        TAG="latest"
        CONTAINER="predprod"
        REMOTE_IP=credentials('slave_ip')
    }
    stages {
        stage('Build') {
            steps {
                // git 'https://github.com/eqweqr/jenkins'
                sh 'docker build -t ${REGISTER}/${IMAGE}:${TAG} .'
            }
        }

        stage('Delivery'){
            steps{
                sh 'echo ${IAMTOKEN} | docker login --username iam --password-stdin cr.yandex'
                sh 'docker push ${REGISTER}/${IMAGE}:${TAG}'
                sh 'echo reached'
            }
        }

        stage('Deploy'){
            steps{
                sshagent(credentials: ['id_rsa']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no -l user1 ${REMOTE_IP}'ls /tmp' 
                    """
                        // 'echo ${IAMTOKEN} | docker login --username iam --password-stdin cr.yandex && docker pull cr.yandex/crpn54p4a8q7gmhfaov4/${IMAGE}:${TAG} && docker stop ${CONTAINER} || true && docker rm ${CONTAINER} || true && docker run --name ${CONTAINER} -d ${REGISTER}/${IMAGE}:${TAG}'
                // """
		}
	}
    }
}
}
