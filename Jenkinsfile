@Library('socrata-pipeline-library@9.7.0') _

commonPipeline(
  jobName: 'grafana',
  language: 'bash',
  projects: [
    [
      name: 'grafana',
      type: 'service',
      deploymentEcosystem: 'ecs',
      paths: [
        dockerBuildContext: '.'
      ],
    ],
  ],
  teamsChannelWebhookId: 'WORKFLOW_TIRE_Q_AND_A',
)
