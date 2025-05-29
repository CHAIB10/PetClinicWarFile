pipeline {
  agent any

  environment {
    DOCKER_IMAGE = "hajar4/petclinic-app:latest"
    DOCKER_CREDENTIALS_ID = "dockerhub-creds" // à créer dans Jenkins
  }

  stages {
    stage('Build App') {
      steps {
        sh '/opt/maven/bin/mvn clean package -DskipTests'
        sh 'cp target/petclinic.war .'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $DOCKER_IMAGE .'
      }
    }

    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: "$DOCKER_CREDENTIALS_ID", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh '''
            echo $PASSWORD | docker login -u $USERNAME --password-stdin
            docker push $DOCKER_IMAGE
          '''
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
       sh 'kubectl apply -f petclinic-deployment.yml'
       sh 'kubectl apply -f petclinic-service.yml'
      }
    }
  }
}
