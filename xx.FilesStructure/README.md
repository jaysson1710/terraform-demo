[[_TOC_]]

# Terraform Guidelines for SoftwareONE Application Services projects

This is the base [Terraform](https://www.terraform.io/) Infrastructure as Code scaffolding to be used in the SoftwareONE application services projects. Here you can find the base structure to create the IaC scripts based on modules and environmentns management.
>
Into the scaffolding you can find:
* Folder schema with main project and module.
* Terraform configurations files separation.
* Pipeline CI for reference.

>
## Best practices
>
### Terraform configurations files separation
Putting all code in `main.tf` is not a good idea, better having several files like:
>
  * `main.tf`: call modules, locals, and data sources to create all resources.
  * `variables.tf`: contains declarations of variables used in `main.tf`
  * `outputs.tf`: contains outputs from the resources created in `main.tf`
  * `providers.tf`: contains details about the used providers.
>
The above files apply to either the main project or modules. The next files only are for the main project:
>
  * `terraform.tfvars`: contains transversal project variables values which one can override with other variable files.
  * `variables.{environment}.tfvars`: contains variables for specific environment.
  * `*.{provider}.tfbackend`: information about backend state configuration.

### Use separate variables files for each environment

* Each environment corresponds to a default Terraform workspace and deploys a version of the service to that environment.
* Use workspace for each environment. ["Link"](https://www.terraform.io/language/state/workspaces)
* Use the same configuration script for each environment over it needs deploy IaC.


### General Naming Conventions
* Provide meaningful resource names.
* Use _ (underscore) instead of - (dash) everywhere (resource names, data source names, variable names, outputs, etc) to delimit multiple words.
* Prefer to use lowercase letters and numbers.
* Always use singular nouns for names.
* Do not repeat resource type in resource name (not partially, nor completely).

### Variables Conventions
* Give variables descriptive names that are relevant to their usage or purpose.
* Provide meaningful description for all variables even if you think it is obvious.
* When appropriate, provide default values.
* Use the plural form in a variable name when type is list(...) or map(...).
* Prefer using simple types (number, string, list(...), map(...)) over specific type like object() unless you need to have strict constraints on each key.
* Avoid hardcoding variables.
* When you consider, using validation into variables way can validate information before using it.

### Outputs Conventions
* Organize all outputs in an `outputs.tf` file.
* Output all useful values that root modules might need to refer to or share.
* Make outputs consistent and understandable outside of its scope.
* Provide meaningful description for all outputs even if you think it is obvious.
* The name of output should describe the property it contains and be less free-form than you would normally want. Good structure for the name of output looks like *`{name}_{type}_{attribute}`*.
>
### Use remote state
* Never to store the state file on your local machine or version control.
* State file may include sensitive values in plain text, representing a security risk, anyone with access to your machine or this file can potentially view it.
* With remote state, Terraform writes the state data to a remote data store, which can be shared between all team members. This approach locks the state to allow for collaboration as a team.
Configure Terraform backend using remote state (shared locations) services such as Amazon S3, Azure Blob Storage, GCP Cloud Storage, Terraform Cloud, Consul.
* It also separates the state and all the potentially sensitive information from version control.
* Don’t commit the .tfstate file source control. To prevent accidentally committing development state to source control, use gitignore for Terraform state files. Use .gitignore
* Don't commit folder `.terraform`. Use .gitignore
* Manipulate state only through the commands.
* Encrypt state: Even though no secrets should be in the state file, always encrypt the state as an additional measure of defense.
* Keep your backends small.
* Back up your state files.
* Use one state per environment.
* When using remote storage, be sure that versioning options it's available over storage, so can check out the previous version for the same infrastructure.

### Use Sensitive flag variables
* Terraform configuration often includes sensitive inputs, such as passwords, API tokens, or Personally Identifiable Information (PII).
* With sensitive flag, Terraform will redact the values of sensitive variables in console and log output, to reduce the risk of accidentally disclosing these values.
* 'sensitive' flag helps prevent accidental disclosure of sensitive values, but is not sufficient to fully secure your Terraform configuration.
>
### Use variable definitions (.tfvars) files
* To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either `.tfvars` or `.tfvars.json`).
* Declare all variables in `variables.{environment}.tf` per environment.
* Specify that file on the command line with `-var-file`: `terraform apply -var-file="variables.{environment}.tfvars”`
* The file terraform.tfvars, could be used how storage for generic variables which one could be applied to every environment, Terraform load this file without a specific command.
* Terraform also automatically loads a number of variable definitions files if they are present.
* It is always suggested to pass variables for a password, secret key, etc. locally through `-var-file` rather than saving it inside terraform configurations or on a remote location version control system.

>
### Use modules
* Modules are meant for reuse, use modules wherever possible.
* It is strongly suggested to use official Terraform modules. No need to reinvent a module that already exists.
* Each module should concentrate on only one aspect of the infrastructure, such as creating instances, databases, etc.
* Make the modules available to organization or project, making use of registries or git repositories for saving them.
* Follow the naming convention for modules, it's highly recommended to compatibility matter: *`terraform-<provider>-<name>`*.
>
### Version control
* Like application code, store infrastructure code in version control to preserve history and allow easy rollbacks.
* Use a default branching strategy (such as GitFlow).
* Encourage infrastructure stakeholders to submit merge requests as part of the change request process.
* Organize repositories based on team boundaries.
>
### Execution
* It's a good practice run `plan` before `apply`.
* Use `apply` command with the execution plan; this way you can be confident that infrastructure will be created based on traced plan.
* Tags are useful for targeting people about what resources you have for each area, topic, environment, etc.
* Use CI & CD process for deploying infrastructure.
* Pass the infrastructure code by code scanneres such as SonarQube, TFSec, Snyk, etc.
* Use the `README.MD` file to record information about the infrastructure, conventions, dependencies, and use mode.
* Use features for keeping secrets and sensitive information own to CI/CD platforms or vault as Azure Key Vault or Terraform Vault, so on, and avoid hard coded this into pipeline tasks.
* Don't save sensitive information as keys or token into the scripts when setting the providers. You can use the providers section into Terraform documentation to understand how to use the different authentication models. [Azure](https://www.terraform.io/language/settings/backends/azurerm) [AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration) [GCP](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication)
* The pipeline available [pipeline](./pipeline/test-terraform-infracost-tfsec.yml) is a functional CI process that keeps the main practices to be aware.
>
>
If you need to use some existing SoftwareOne module, you need to require access to **accessTerraform@softwareone.com**.
