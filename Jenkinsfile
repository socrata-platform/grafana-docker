@Library('socrata-pipeline-library@9.0.0') _

commonPipeline(
  jobName: 'grafana',
  language: 'bash',
  projects: [
    [
      name: 'grafana',
      type: 'service',
      deploymentEcosystem: 'marathon-mesos',
      paths: [
        dockerBuildContext: '.'
      ],
    ],
  ],
  teamsChannelWebhookId: 'WORKFLOW_TIRE_Q_AND_A',
)
