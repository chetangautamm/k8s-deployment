pipeline {

  environment {
    registry = "chetangautamm/repo"
    registryCredential = '58881f31-29bb-48a8-9da9-fc254654146d' 
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source Code') {
      steps {
        git 'https://github.com/chetangautamm/k8s-deployment.git'
      }
    }
    
    
    stage('Deploying Opensips CNF on Pre-Prod Environment') {
      steps {
        sshagent(['k8suser']) {
          sh "scp -o StrictHostKeyChecking=no -q opensips.yaml k8suser@52.172.221.4:/home/k8suser"
          script {
            try {
              sh "ssh k8suser@52.172.221.4 kubectl apply -f opensips.yaml"
            }catch(error){
              sh "ssh k8suser@52.172.221.4 kubectl apply -f opensips.yaml"
            } 
          }
        }              
      }
    }
    stage('Validating Opensips Using SIPp on Pre-Prod Environment') {
      steps {
        sh "chmod +x configure.sh"
        sshagent(['k8suser']) {
          sh "scp -o StrictHostKeyChecking=no -q configure.sh k8suser@52.172.221.4:/home/k8suser"
          script {
            sh "sleep 10"
            sh "ssh k8suser@52.172.221.4 ./configure.sh"
          }
        }              
      }
    }
    stage('Deploying Opensips CNF on Prod Environment') {
      steps {
        sshagent(['k8s-host1-local']) {
          sh "scp -o StrictHostKeyChecking=no -q opensips.yaml k8s-host1@192.168.1.207:/home/k8s-host1"
          script {
            try {
              sh "ssh k8s-host1@192.168.1.207 kubectl apply -f opensips.yaml"
            }catch(error){
              sh "ssh k8s-host1@192.168.1.207 kubectl apply -f opensips.yaml"
            } 
          }
        }              
      }
    }
    stage('Validating Opensips Using SIPp on Prod Environment') {
      steps {
        sh "chmod +x configure.sh"
        sshagent(['k8s-host1-local']) {
          sh "scp -o StrictHostKeyChecking=no -q configure.sh k8s-host1@192.168.1.207:/home/k8s-host1"
          script {
            sh "sleep 10"
            sh "ssh k8s-host1@192.168.1.207 ./configure.sh"
          }
        }              
      }
    }
  }
}
