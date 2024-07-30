pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
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
        recordIssues tools: [mavenConsole()], qualityGates: [[threshold: 1, type: 'TOTAL']]
      }
    }
  }
}
