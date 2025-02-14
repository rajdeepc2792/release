{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'mirroring-failures',
        rules: [
          {
            alert: 'mirroring-failures',
            expr: |||
              increase(prowjob_state_transitions{job_name="periodic-image-mirroring-openshift",state="failure"}[5m]) > 0
            |||,
            'for': '1m',
            labels: {
              severity: 'critical',
              team: '%s' % $._config.alertManagerReceivers['patch-manager'].team,
            },
            annotations: {
              message: '@%s image mirroring jobs have failed. View failed jobs at the <https://prow.ci.openshift.org/?job=periodic-image-mirroring-openshift|overview>.  If there is a consistent issue, open a bugzilla bug against Test Infrastructure and help drive it to resolution.' % $._config.alertManagerReceivers['patch-manager'].notify,
            },
          }
        ],
      },
    ],
  },
}
