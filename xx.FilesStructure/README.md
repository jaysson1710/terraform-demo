[[_TOC_]]

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
