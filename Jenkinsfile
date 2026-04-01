@Library('socrata-pipeline-library@10.2.1') _

commonPipeline(
  jobName: 'grafana',
  projects: [
    [
      name: 'grafana',
      type: 'service',
      deploymentEcosystem: 'ecs',
      docker: [
        buildContext: '.'
      ],
      language: 'bash',
    ],
  ],
  teamsChannelWebhookId: 'WORKFLOW_TIRE_Q_AND_A',
)
