pipeline {

  environment {
    registry = "chetangautamm/repo"
    registryCredential = '58881f31-29bb-48a8-9da9-fc254654146d' 
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/chetangautamm/k8s-deployment.git'
      }
    }
    
    
    stage('Deploy APP') {
      steps {
        sh "chmod +x configure.sh"
        sh "chmod +x server.sh"
        sh "chmod +x client.sh"
        sshagent(['k8suser']) {
          sh "scp -o StrictHostKeyChecking=no -q opensips.yaml k8suser@52.172.221.4:/home/k8suser"
          sh "scp -o StrictHostKeyChecking=no -q configure.sh k8suser@52.172.221.4:/home/k8suser"
          sh "scp -o StrictHostKeyChecking=no -q server.sh k8suser@52.172.221.4:/home/k8suser"
          sh "scp -o StrictHostKeyChecking=no -q client.sh k8suser@52.172.221.4:/home/k8suser"
          script {
            try {
              sh "ssh k8suser@52.172.221.4 kubectl apply -f opensips.yaml"
            }catch(error){
              sh "ssh k8suser@52.172.221.4 kubectl apply -f opensips.yaml"
            } 
            sh "sleep 10"
            sh "ssh k8suser@52.172.221.4 ./configure.sh"
            sh "ssh -t k8suser@52.172.221.4 ./server.sh"
            sh "ssh -t k8suser@52.172.221.4 ./client.sh"
          }
        }              
      }
    }
  }
}
