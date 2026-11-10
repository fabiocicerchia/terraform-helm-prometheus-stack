@domain:integration @area:usage-example @from:examples/examples
Feature: Deploying the monitoring stack from the sample root module
  Gives operators a working starting point that shows how to call the module and read back what it deployed.

  Background:
    Given the operator has a Kubernetes cluster reachable by the Helm provider

  @id:integration.usage-example.003 @rule:examples.usage.chart-values-encoded-twice @inferred @source:examples/main.tf#prometheus @questionable
  Scenario: The sample's chart values reach Helm as a quoted text value, not as a map of settings
    Given the sample passes its values already encoded as YAML text
    When the operator applies the sample
    Then Helm receives the YAML document "{}" as a quoted string instead of an empty map of settings
    And the install is likely refused because the values are not a map

  @id:integration.usage-example.004 @rule:examples.usage.helm-provider-limited-to-2x @inferred @source:examples/main.tf#terraform @questionable
  Scenario: The sample accepts only 2.x versions of the Helm provider, though the module allows newer ones
    Given only a Helm provider of major version 3 or later is available
    When the operator initialises the sample
    Then initialisation is refused because no provider version matches "~> 2.0"
    And the module on its own would accept that provider, since it requires ">= 2.0"
