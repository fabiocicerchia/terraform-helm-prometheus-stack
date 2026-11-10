@domain:integration @area:compatibility @from:terraform-helm-prometheus-stack/versions
Feature: Declaring supported Terraform, OpenTofu and Helm provider versions
  Tells platform operators which Terraform/OpenTofu and Helm provider versions they can use the module with, so an unsupported toolchain is turned away before it touches the cluster.

  Background:
    Given the operator's root configuration calls the prometheus-stack module

  @id:integration.compatibility.001 @rule:integration.compatibility.minimum-terraform-version @inferred @source:versions.tf#terraform
  Scenario Outline: Only Terraform 1.0 or newer, or any OpenTofu release, can run the module
    Given the operator runs <tool> version <cli_version>
    When the operator initialises the root configuration
    Then initialisation <outcome>
    And when refused, the operator is told the configuration requires a core version of ">= 1.0"

    Examples:
      | tool      | cli_version | outcome                                           |
      | Terraform | 0.15.5      | is refused with an unsupported core version error |
      | Terraform | 1.0.0       | goes ahead                                        |
      | Terraform | 1.9.8       | goes ahead                                        |
      | OpenTofu  | 1.6.0       | goes ahead                                        |

  @id:integration.compatibility.002 @rule:integration.compatibility.minimum-helm-provider-version @inferred @source:versions.tf#terraform
  Scenario Outline: The module needs version 2.0 or newer of the HashiCorp Helm provider
    Given the only hashicorp/helm provider version available to the operator is <provider_version>
    When the operator initialises the root configuration
    Then initialisation <outcome>

    Examples:
      | provider_version | outcome                                                           |
      | 1.3.2            | is refused because no available provider version matches ">= 2.0" |
      | 2.0.0            | goes ahead and installs hashicorp/helm 2.0.0                      |
      | 3.0.2            | goes ahead and installs hashicorp/helm 3.0.2                      |
