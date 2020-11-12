pipeline {
  agent {
    docker {
      image 'maven:3.6.3-openjdk-11'
    }
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }

  triggers {
    cron '@midnight'
  }

  stages {
    stage('build') {
      steps {
        sh './generate.sh'

        script {
          maven cmd: 'clean deploy'          
        }
        archiveArtifacts 'target/*.zip'
        recordIssues tools: [mavenConsole()], unstableTotalAll: 1
      }
    }
  }
}
