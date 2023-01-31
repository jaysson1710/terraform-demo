variable "functionname" {
  type        = string
  description = "Nombre de la funcion a crear"
}
variable "resource_group_name" {
  type        = string
  description = "Nombre del respurce group donde ubicar la funcion"
}
variable "location" {
  type        = string
  description = "Localizacion"
}

variable "tags" {
  type        = map(string)
  description = "Tags key/value aplicables a la funcion y plan."
}
variable "storage_account_object" {
  description = "Informacion del storage a asociar a la funcion"
}

variable "runtime" {
  type        = string
  description = "Stack tecnologico a crear la funcion"
}

variable "connection_string_database" {
  type        = string
  description = "cadena de conexion a la DB"
}

variable "sku" {
  type        = string
  description = "(optional) describe your variable"
}
variable "os" {
  type        = string
  description = "sistema operativo para la funcion"
}