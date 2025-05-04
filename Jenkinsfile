pipeline {
    agent any 
	parameters {
		string(name: 'EXPIRED_DAYS', defaultValue: '7', description: 'max time for image')
		string(name: 'MAX_SIZE', defaultValue: '1000', description: 'max commulitive size for iamges in registory')
	}
    environment {
        IAMTOKEN=credentials('iamtoken')
        REGISTER=credentials('register')
	REGISTERID=credentials('regid')
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
//		sh 'docker rmi  ${REGISTER}/${IMAGE}:${TAG}'
            }
        }

        stage('Deploy'){
            steps{
                sshagent(credentials: ['id_rsa']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no -l user1 ${REMOTE_IP} 'echo ${IAMTOKEN} | docker login --username iam --password-stdin cr.yandex && docker pull ${REGISTER}/${IMAGE}:${TAG} && docker stop ${CONTAINER} || true && docker rm ${CONTAINER} || true && docker run --name ${CONTAINER} -d ${REGISTER}/${IMAGE}:${TAG}'
                 """
		}
	}
    }
//	stage('Cleanup'){
//		steps{
//		sh './test.sh ${IAMTOKEN} ${REGISTERID} ${params.EXPIRED_DAYS} ${params.MAX_SIZE}' 	
//		}
//}
}
}
