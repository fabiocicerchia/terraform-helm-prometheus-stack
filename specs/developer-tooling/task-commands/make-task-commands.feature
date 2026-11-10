@domain:developer-tooling @area:task-commands @from:terraform-helm-prometheus-stack/makefile
Feature: Running the standard task commands
  Gives contributors the same make verbs as every other repository in the estate, so they can set up, lint and format the module without reading the Makefile.

  Background:
    Given the contributor has a checkout of the module

  @id:developer-tooling.task-commands.001 @rule:devtooling.make.bare-make-lists-verbs @inferred @source:Makefile#help
  Scenario: Running make with no verb lists the available verbs
    When the contributor runs make with no verb
    Then each documented verb is printed with its one-line description
    And the list includes help, setup, install, lint, format, test, analyze, build and run

  @id:developer-tooling.task-commands.002 @rule:devtooling.make.inapplicable-verbs-explain-themselves @inferred @source:Makefile#build
  Scenario Outline: Verbs that make no sense for a module succeed and say why
    When the contributor runs make <verb>
    Then the command exits with status 0
    And the message "<message>" is printed
    And the contributor is pointed to the README's "Not applicable" section

    Examples:
      | verb  | message                                                                  |
      | build | Nothing to build: this is a Terraform module, consumed from source.      |
      | run   | Nothing to run: a module is called by a root module, never run directly. |

  @id:developer-tooling.task-commands.003 @rule:devtooling.make.analyze-requires-tflint @inferred @source:Makefile#analyze
  Scenario: Static analysis is refused when tflint is not installed
    Given tflint is not installed on the contributor's machine
    When the contributor runs make analyze
    Then the message "analyze needs tflint: https://github.com/terraform-linters/tflint" is shown on standard error
    And the analyze recipe exits with status 69, so make reports the verb as failed
    And no analysis is run
