@domain:integration @area:usage-example @from:examples/outputs
Feature: Re-exporting deployment facts from the usage example
  Gives operators who copy the sample root module the deployed namespace, release name and chart version under clearly prefixed output names, so they can wire them into other tooling.

  Background:
    Given the operator has applied the usage example, which deploys the monitoring stack as release "prometheus" in namespace "prometheus-system"

  @id:integration.usage-example.005 @rule:examples.outputs.reexports-module-outputs-with-prometheus-prefix @inferred @source:examples/outputs.tf#prometheus_namespace
  Scenario Outline: The usage example reports each deployment fact under a prometheus-prefixed output
    Given the monitoring stack module reports its <module_output> as <value>
    When the operator reads the outputs of the usage example
    Then the output <example_output> is shown
    And its value is <value>
    And its description reads "<description>"

    Examples:
      | module_output | example_output           | value                            | description                                  |
      | namespace     | prometheus_namespace     | prometheus-system                | The namespace where Prometheus is deployed   |
      | release_name  | prometheus_release_name  | prometheus                       | The Helm release name of Prometheus          |
      | chart_version | prometheus_chart_version | the chart version Helm installed | The chart version of the deployed Prometheus |
