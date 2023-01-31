terraform {

}

variable "cadena" {
    type = string
    description = "(optional) describe your variable"
}

variable "map" {
    type = map(string)
    description = "(optional) describe your variable"
    default = {
        key1 = "val1"
        key2 = "val2"
    }
}

## lista
variable "lista" {
  type = list(string)
  default = [ "value1","valor2" ]
}

## lista ordenada
variable "set" {
  type = set(number)
  default = [ 1,5,3 ]
}

## tuple
variable "tuple" {
  type = tuple([any,any])
  description = "(optional) describe your variable"
  default = ["val1",true]
}

locals {
  valor1 = true
  valor2 = "int"
  valor3 = tomap({valor=0, status = true, name = "test2"}) ## transformacion valores al que coincida
  valor_object = {valor=0, status = true, name = "test2"} ## object
}


output "describe" {
  value = var.set
}

output "valor3" {
  value = local.valor3
}

output "cadena" {
  value = var.cadena
}

output "object" {
  value = local.valor_object
}

output "tuple" {
  value = var.tuple
}