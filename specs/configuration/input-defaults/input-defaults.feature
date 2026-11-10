@domain:configuration @area:input-defaults @from:terraform-helm-prometheus-stack/variables
Feature: Deploying the monitoring stack with default inputs
  Lets an operator install the monitoring stack by calling the module with no inputs and get a predictable, documented release.

  Background:
    Given the operator calls the prometheus stack module from a root module

  @id:configuration.input-defaults.001 @rule:configuration.inputs.release-and-namespace-defaults @inferred @source:variables.tf#release_name
  Scenario Outline: An omitted release name or namespace falls back to its documented default
    Given the operator does not set the "<input>" input
    When the operator applies the configuration
    Then the stack is deployed with <input> "<default>"
    And the module's "<input>" output reports "<default>"

    Examples:
      | input        | default              |
      | release_name | prometheus-community |
      | namespace    | monitoring           |

  @id:configuration.input-defaults.002 @rule:configuration.inputs.chart-version-defaults-to-latest @inferred @source:variables.tf#chart_version
  Scenario: Leaving the chart version unset installs the latest chart release
    Given the operator does not set a chart version, or sets it to an empty string
    When the operator applies the configuration
    Then the latest published kube-prometheus-stack chart is installed
    And no chart version is pinned for the release

  @id:configuration.input-defaults.003 @rule:configuration.inputs.no-value-overrides-by-default @inferred @source:variables.tf#values
  Scenario: Without value overrides the chart is installed with its own defaults
    Given the operator does not set any Helm values
    When the operator applies the configuration
    Then the stack is installed with the kube-prometheus-stack chart's default settings
