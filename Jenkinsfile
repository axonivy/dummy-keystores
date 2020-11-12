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
          maven cmd: '-f pom-designer.xml clean deploy'
          maven cmd: '-f pom-engine.xml clean deploy'          
        }
        archiveArtifacts 'generated/**/*'
        recordIssues tools: [mavenConsole()], unstableTotalAll: 1
      }
    }
  }
}
