pipeline {
    agent any 
    environment {
        MY_CRED = credentials('mycred')
    }
    stages {
        stage('Example stage 1') {
            steps {
		git 'https://github.com/eqweqr/jenkins'
		sh 'docker build -t hello .'
		sh 'docker run -t --rm --name kk hello'
		echo "$MY_CRED"
                // sh("kubectl --kubeconfig $MY_KUBECONFIG get pods")
            }
        }
    }
}
