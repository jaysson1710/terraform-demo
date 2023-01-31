## Taller parte 4
>
> :watch: 90 min
>
### Objetivo
>
- Manejo de pipelines
    - Verificación de sonar 
    - Análisis de seguridad (cualquier herramienta)
    - Análisis de costos
>
### Actividades
>
Con el proposito de aplicar practicas de CI/CD a la IaC y permitir el trabajo colaborativo.
>
1. Seleccionar la plataforma con la cual realizar los procesos de CI GitHub, Azure devops, CicleCI, etc..
2. Desarrollar pipeline con las siguientes actividades
  - Terraform init y plan
  - Validar el codigo con SonarQube
  - Valores de configuración 
    - Url **http://sonarjason22.eastus.cloudapp.azure.com:9000/**
    - Token **85fd6e5f87ff32d7f42975bf9fc2129cc813178f**
  - Configuración de tarea con [InfraCost](https://www.infracost.io/docs/guides/v0.10_migration/), 
    - Enlace de configuracion [Link](https://www.infracost.io/docs/)
    - Dependiendo de la plataforma de CI seleccionada, en el siguiente [link](https://www.infracost.io/docs/integrations/cicd/) puede encontrar informacion relacionada.
    - Ejemplo invocación tarea infracost 
    ```bash
    infracost breakdown --path=tfplan --format=html --out-file=infracost.html --show-skipped
    ```
  - Aplicar herramienta de inspección de seguridad ([tfsec](https://github.com/aquasecurity/tfsec), [snyk](https://docs.snyk.io/integrations/ci-cd-integrations), etc..)

    Ejemplo configuración tfsec sobre linux
    ```sh

    wget -q -O tfsec https://github.com/aquasecurity/tfsec/releases/download/v0.58.6/tfsec-linux-amd64  \
      && chmod +x ./tfsec

    ./learn-terraform-azure/tfsec .  --soft-fail --format junit >> junit.xml 

    ```
>
  - Verificar cada uno de los resultados generados, ya sea sobre las plataforma de analisis destino o sobre la misma de CI/CD segun sea el caso.
>
Nota: En el siguiente enlace, puede encontrar un paso a paso para la implementación del pipeline base [Deploying Terraform Infrastructure using Azure DevOps Pipelines Step by Step](https://gmusumeci.medium.com/deploying-terraform-infrastructure-using-azure-devops-pipelines-step-by-step-d58b68fc666d)