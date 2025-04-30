pipeline {
    agent any 
    environment {
        MY_CRED = credentials('mycred')
    }
    stages {
        stage('Example stage 1') {
            steps {
		echo "$MY_CRED"
                // sh("kubectl --kubeconfig $MY_KUBECONFIG get pods")
            }
        }
    }
}
