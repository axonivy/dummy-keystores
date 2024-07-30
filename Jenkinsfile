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
          dir ('designer') {
            def phase = isReleaseOrMasterBranch() ? 'deploy' : 'verify'
            maven cmd: "clean ${phase}"
          }
          dir ('engine') {
            def phase = isReleaseOrMasterBranch() ? 'deploy' : 'verify'
            maven cmd: "clean ${phase}"
          }
        }
        archiveArtifacts '**/generated/**/*'
        recordIssues tools: [mavenConsole()], qualityGates: [[threshold: 1, type: 'TOTAL']]
      }
    }
  }
}

def isReleaseOrMasterBranch() {
  return env.BRANCH_NAME == 'master' || env.BRANCH_NAME.startsWith('release/') 
}
