pipeline {
    agent any 
    environment {
        MY_CRED = credentials('mycred')
    }
    stages {
        stage('Example stage 1') {
            steps {
		https://github.com/eqweqr/jenkins
		docker build -t hello .
		docker run -t --rm --name kk hello
		echo "$MY_CRED"
                // sh("kubectl --kubeconfig $MY_KUBECONFIG get pods")
            }
        }
    }
}
