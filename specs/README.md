# Specifications of terraform-helm-prometheus-stack

What this code does, one atomic Gherkin scenario per behaviour, read from the code by code-atlas.
Tags: `@verified` a test asserts it · `@inferred` read from the code only · `@gap` an entry point no test covers · `@human` written or amended by a person, never rewritten.

## Configuration
How a caller tailors the monitoring stack through module inputs.

- **Inputs and defaults**: [Deploying the monitoring stack with default inputs](configuration/input-defaults/input-defaults.feature) (3)

## Developer tooling
Commands and checks that keep the module buildable, consistent and correct.

- **Task commands**: [Running the standard task commands](developer-tooling/task-commands/make-task-commands.feature) (3)
- **Validation**: [Validating the module and its example](developer-tooling/validation/make-validation.feature) (1)

## Integration
What the module exposes to callers and what it needs from their environment.

- **Tool and provider compatibility**: [Declaring supported Terraform, OpenTofu and Helm provider versions](integration/compatibility/tool-provider-compatibility.feature) (2)
- **Deployment outputs**: [Reporting what was deployed](integration/deployment-outputs/deployment-outputs.feature) (2)
- **Usage example**: [Re-exporting deployment facts from the usage example](integration/usage-example/example-reexported-outputs.feature) (1), [Deploying the monitoring stack from the sample root module](integration/usage-example/usage-example.feature) (2)
