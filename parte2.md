## Taller parte 2
>
> :watch: 120 min
>
### Objetivo
>
- Creación de módulos
- Aplicación de funciones
- Aplicación de loops y condicionales
>
### Actividades
>
#### Modularización
>
Para esta actividad, se requiere que ya varios de los recursos de la infraestructura esten creados. Enlace a la documentación [Link](https://www.terraform.io/language/modules/develop), recuerda navegar por las sub-secciones disponibles en la página.
>
1. Crear una carpeta dentro de la raíz con el nombre del módulo a crear.
2. Crear archivos `main.tf` `variables.tf` `outputs.tf` .
3. Registrar en cada archivo, la información correspondiente del recurso o recursos que se van a incluir en el modulo.
4. Dentro del archivo `main.tf` del directorio raíz, invocar el modulo creado.
>
Ejemplo: 
```tf
module "vnet_local" {
    source = "./folder"
    variable = xxxxx
    ...
}
```
>
5. En la opción source, apuntar a la carpeta creada para el módulo.
6. Pasar todas las variables requeridas por el módulo.
7. Validar el desarrollo realizado, cuando este listo puede proceder a aplicar los cambios.
>
>
#### Aplicación de loops
>
El objetivo es simplificar el código de infraestructura, una manera de hacerlo es quitando la redundacia de los bloques de recursos.
>
1. Unificar los bloques de creación del storage.
    - Usar la opción `count =` para identificar la cantidad de storage y establecer los valores [Link](https://www.terraform.io/language/meta-arguments/count)
2. Unificar los bloques de creacion de las subnet.
    - Usar la opción [For_each](https://www.terraform.io/language/meta-arguments/for_each) para iterar entre los nombres de recursos disponibles, para lo cual, previamente los nombres deben estar cargados en una variable tipo lista.
>
#### Aplicación de funciones
>
1. Generar espacio de direcciones de red para subnets.
    - Generar variable local que contenga los nombres de las subnets.
    - Generar variable local que contenga las los espacios de direcciones para las subnets.
      - Usar la función [cidrsubnets](https://www.terraform.io/language/functions/cidrsubnets).
    - En el script dejar un solo bloque de creación de subnets.
    - Usar cada uno de los registro generados en el bloque de configuración de la subnet. Puede usar count, for_each, for, etc..
2. Concatenar cadenas para generación de nombres de recursos .
    - Para los recursos generados, hacer uso de [interpolación](https://www.terraform.io/language/expressions/strings#interpolation) para concatenar valores.
      - La idea es crear los recursos con prefijos que ayuden a identificarlos mas facilmente, ejemplo: "RG-{nombre grupo de recursos}".
    - Para otros recursos, aplicar la función [format](https://www.terraform.io/language/functions/format) para generar el nombre de estos.
    - En el siguiente enlace puede encontrar mas información de las funciones disponibles [link](https://www.terraform.io/language/functions).
    - Verificar y aplicar cambios.
    - Confirmar asignación correcta de nombres a los recursos.
3. Aplicación de función `tomap()` para concatenar valores a registrar en los tags.
    - Todos los recursos que se crean, idealmente deben estar bien identificados, por lo que se requiere aplicar el mismo conjunto de tags a cada uno de los recursos desplegados. Dado que los tags se estructuran como `key value` se pude hacer uso de la funcion [map](https://www.terraform.io/language/functions/map).
    - Crear una variable local para el registro de los tags a aplicar.
    - Usar la función tomap para enlazar valores provenientes desde las variables.
    >
      Ejemplo
      >
      ```json
        tag = tomap({
          name = "a"
          id   = 123
          env = terraform.workspace
        })
      ```
      >
    - Usar la función [merge](https://www.terraform.io/language/functions/merge) para enlazar valores a la variable tag creada.
    - Aplicar los tags a cada recurso creado.
      ejemplo
      ```json
        resource "azurerm_resource_group" "rg" {
          ...
          tags     = local.valores
        }
      ```
    - Verificar y aplicar
    - Confirmar que los recursos creados tienen los tags correctos.
  >
4. Condicionales
  - Usar la expresión [condicional](https://www.terraform.io/language/expressions/conditionals) para decidir entre dos valores a seleccionar.
  - Cree una variable sizeSku tipo lista.
  - La variable tiene dos opciones disponibles `peq y gran`.
  - Usar esta variable en la creación de la bas de datos .
  - Usar la expresión condicional para seleccionar un tamaño que exista en la plataforma destino.
  - Verificar y aplicar los cambios.
  - Confirmar variación en el tamaño del disco segun validación en el condicional.
>