@domain:integration @area:deployment-outputs @from:terraform-helm-prometheus-stack/outputs
Feature: Reporting what was deployed
  Lets the operator and any calling configuration learn the namespace, release name and chart version the monitoring stack actually ended up with, so they can wire other systems to it.

  Background:
    Given the operator calls the prometheus stack module against a Kubernetes cluster

  @id:integration.deployment-outputs.001 @rule:integration.deployment-outputs.namespace-reported @inferred @source:outputs.tf#namespace
  Scenario Outline: The namespace and Helm release name of the stack are reported
    Given the operator sets the <input> input to <input_value>
    When the operator applies the configuration
    Then the "<input>" output is "<reported>"

    Examples:
      | input        | input_value   | reported             |
      | namespace    | (not set)     | monitoring           |
      | namespace    | observability | observability        |
      | release_name | (not set)     | prometheus-community |
      | release_name | kps-acme      | kps-acme             |

  @id:integration.deployment-outputs.003 @rule:integration.deployment-outputs.chart-version-reported @inferred @source:outputs.tf#chart_version
  Scenario Outline: The chart version actually installed is reported
    Given the operator sets the chart version input to <chart_version_input>
    When the operator applies the configuration
    Then the "chart_version" output is <reported_chart_version>

    Examples:
      | chart_version_input | reported_chart_version                                  |
      | "65.1.0"            | "65.1.0"                                                |
      | "" (latest)         | the version of kube-prometheus-stack that was installed |
