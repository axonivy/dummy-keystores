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
          dir ('engine') {
            def phase = isReleasingBranch() ? 'deploy' : 'verify'
            maven cmd: "clean ${phase}"
          }
        }
        archiveArtifacts '**/generated/**/*'
        recordIssues tools: [mavenConsole()], qualityGates: [[threshold: 1, type: 'TOTAL']]
      }
    }
  }
}
