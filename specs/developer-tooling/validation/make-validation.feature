@domain:developer-tooling @area:validation @from:terraform-helm-prometheus-stack/makefile
Feature: Validating the module and its example
  Lets contributors confirm that both the module and its usage example are valid Terraform before they publish a change, without configuring a backend.

  Background:
    Given the contributor has a checkout of the module

  @id:developer-tooling.validation.001 @rule:devtooling.validation.module-and-example-validated @inferred @source:Makefile#test
  Scenario: Testing validates both the module and its usage example without a backend
    Given no Terraform backend is configured
    When the contributor runs make test
    Then the module is initialised without a backend and validated
    And the examples directory is then initialised without a backend and validated
    And the command fails if either one is invalid
