@Library('socrata-pipeline-library')

String lastStage

def dockerize = new com.socrata.Dockerize(steps, 'grafana', env.BUILD_NUMBER)

pipeline {
  options {
    ansiColor('xterm')
    buildDiscarder(logRotator(numToKeepStr: '20'))
    disableConcurrentBuilds(abortPrevious: true)
    timeout(time: 20, unit: 'MINUTES')
  }
  parameters {
    string(name: 'AGENT', defaultValue: 'build-worker', description: 'Which build agent to use?')
    string(name: 'BRANCH_SPECIFIER', defaultValue: 'origin/main', description: 'Which branch to build')
    booleanParam(name: 'RELEASE_BUILD', defaultValue: false, description: 'Are we building a release candidate?')
  }
  agent {
    label params.AGENT
  }
  environment {
    SERVICE = 'grafana'
  }
  stages {
    stage('Docker Build') {
      steps {
        script {
          lastStage = env.STAGE_NAME
          env.SERVICE_VERSION = (params.RELEASE_BUILD) ? 'RELEASE' : 'STAGING'
          env.DOCKER_TAG = dockerize.dockerBuildWithDefaultTag(
            version: SERVICE_VERSION,
            sha: env.GIT_COMMIT
          )
        }
      }
    }
    stage('Publish') {
      steps {
        script {
          lastStage = env.STAGE_NAME
          if (params.RELEASE_BUILD) {
            env.BUILD_ID = dockerize.publish(sourceTag: env.DOCKER_TAG)
          } else {
            env.BUILD_ID = dockerize.publish(
              sourceTag: env.DOCKER_TAG,
              environments: ['internal']
            )
          }
          currentBuild.description = env.BUILD_ID
        }
      }
    }
    stage('Deploy') {
      steps {
        script {
          lastStage = env.STAGE_NAME
          env.ENVIRONMENT = (params.RELEASE_BUILD) ? 'rc' : 'staging'
          marathonDeploy(
            serviceName: env.SERVICE,
            tag: env.BUILD_ID,
            environment: env.ENVIRONMENT
          )
        }
      }
    }
  }
  post {
    failure {
      withCredentials([string(credentialsId: 'EMAIL_TIRE', variable: 'EMAIL_TO')]) {
        emailext (
          to: EMAIL_TO,
          subject: "${env.SERVICE} - [${env.BUILD_NUMBER}] failed in stage ${lastStage}",
          body: """<p>Check console output at <a href='${env.BUILD_URL}'>${env.BUILD_URL}</a></p>""",
        )
      }
    }
  }
}
