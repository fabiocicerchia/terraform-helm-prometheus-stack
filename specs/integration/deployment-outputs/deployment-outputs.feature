@domain:integration @area:deployment-outputs @from:terraform-helm-prometheus-stack/outputs
Feature: Reporting what was deployed
  Lets the operator and any calling configuration learn the namespace, release name and chart version the monitoring stack actually ended up with, so they can wire other systems to it.

  Background:
    Given the operator applies the prometheus stack module to a Kubernetes cluster

  @id:integration.deployment-outputs.001 @rule:integration.deployment-outputs.namespace-reported @inferred @source:outputs.tf#namespace
  Scenario Outline: The namespace the stack runs in is reported
    Given the operator sets the namespace input to <namespace_input>
    When the operator applies the configuration
    Then the "namespace" output is "<reported_namespace>"

    Examples:
      | namespace_input | reported_namespace |
      | (not set)       | monitoring         |
      | observability   | observability      |

  @id:integration.deployment-outputs.002 @rule:integration.deployment-outputs.release-name-reported @inferred @source:outputs.tf#release_name
  Scenario Outline: The Helm release name of the stack is reported
    Given the operator sets the release name input to <release_name_input>
    When the operator applies the configuration
    Then the "release_name" output is "<reported_release_name>"

    Examples:
      | release_name_input | reported_release_name |
      | (not set)          | prometheus-community  |
      | kps-acme           | kps-acme              |

  @id:integration.deployment-outputs.003 @rule:integration.deployment-outputs.chart-version-reported @inferred @source:outputs.tf#chart_version
  Scenario Outline: The chart version actually installed is reported
    Given the operator sets the chart version input to <chart_version_input>
    When the operator applies the configuration
    Then the "chart_version" output is <reported_chart_version>

    Examples:
      | chart_version_input | reported_chart_version                                  |
      | "65.1.0"            | "65.1.0"                                                |
      | "" (latest)         | the version of kube-prometheus-stack that was installed |
