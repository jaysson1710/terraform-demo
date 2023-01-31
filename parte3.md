## Taller parte 3
>
> :watch: 160 min
>
### Objetivo
>
- Uso de backend remoto
- Invocación de templates
- Verificación de variables
- Aplicar configuración de VM
>
### Actividades
>
#### Backend remoto
>
1. Configuración del [backend remoto](https://www.terraform.io/language/settings/backends/configuration) en el bloque principal de terraform.
    Ejemplo:
    >
    ```json
    backend "remote" {
        hostname = "app.terraform.io"
        organization = "company"

        workspaces {
          name = "my-app-prod"
        }
      }
    ```
2. Aplicar configuración dependiendo del lugar donde se vaya a almacenar el estado de la infraestructura, en el mismo enlace anterior pueden encontrar las opciones disponibles.
3. Ejecutar `terraform init` para que la aplicación tome los cambios del backend.
3. Validar y aplicar cambios.
4. Confirmar que en el repositorio seleccionado se encuentra el nuevo state.
>
#### Invocación de templates
>
Independientemente del proveedor con que se este trabajando, la esencia es la misma, poder llamar scripts de despliegue del proveedor directamente desde terraform.
>
1. Ubicar documentación del proveedor para el despliegue de plantillas .
>Ejemplo: [AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) [Azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/template_deployment)
2. Seleccionar un recurso a crear e invocar el template del proveedor dentro del código.
3. Verificar y aplicar.
4. Confirmar que el recurso fue desplegado en la plataforma destino.
>
#### Verificación de variables
>
1. Seleccionar 2 o 3 variables con las cuales de vaya a trabajar
2. Aplicar la configuración [Reglas de validación](https://www.terraform.io/language/values/variables#custom-validation-rules)
3. Generar tres tipos de reglas de validación diferentes.
4. Confirmar que los valores registrados con contrados mediante las validaciones realizadas.

#### Configurar VM
>
Para esta parte, se debe contar con un script de configuración de maquinas virtuales, proceder a la página de recursos del proveedor seleccionado en terraform y aplicar el ejemplo disponible.
>
El objetivo es aplicar una configuración sobre la máquina que se despliega, para lo cual se hará uso de los [Provisioners](https://www.terraform.io/language/resources/provisioners/syntax).
>
Configuración a aplicar: 
- Establecer variable de entorno con la conexión al storage.
- Establecer variable de entorno con la conexión a la base de datos.

    (Buscamos establecer la comunicacion de los diferentes recursos creados con la nueva maquina virtual. Recuerda la estructura que se usa en la organizacion de los archivos).
>
1. En el bloque de definición de la máquina virtual, especificar la propiedad *connection*. Dependiendo del SO usado, las propiedades de conexión [aqui](https://www.terraform.io/language/resources/provisioners/connection) pueden variar.

```json
##.. recursos ...

resource "azurerm_virtual_machine" "main" {
  name                  = "xxx"
  location              = azurerm_resource_group.  
  ....
  connection {
    type     = "ssh"
    user     = "xxxx"
    password = "xxxx"
    host     = azurerm_public_ip.publicip.ip_address
  }
}
```
2. En el mismo bloque de definición de la VM usar la opción `provisioner "remote-exec"`. Mas información [aqui](https://www.terraform.io/language/resources/provisioners/remote-exec)
>
Ejemplo:
```json
##.. vm ...
  provisioner "remote-exec" {
    inline = [
      "commands",
    ]
  }
}
```
3. Verificar y ejecutar los cambios.
4. Ingresar a la maquina destino, y verificar que los cambios fueron aplicados.
