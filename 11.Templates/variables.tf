variable "rg" {
    default = "RG-EAU-ECP-DEV-ejemplo"
    description = "(optional) describe your variable"
}

# variable "subnetPrefix" {
#     default = "10.0.0.0/24"
#     description = "(optional) describe your variable"
# }

variable "user" {
    type = string
    description = "(optional) describe your variable"
}

variable "password" {
    type = string
    description = "(optional) describe your variable"
}

variable "nameInstanceSQL" {
    type = string
    description = "(optional) describe your variable"
}

# variable "virtualNetworkName" {
#     default = "VN-EAU-ECP-DEV-ejemplo"
#     description = "(optional) describe your variable"
# }