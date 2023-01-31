terraform init
terraform validate
terraform plan

terraform console
    "cadena-interpolacion-${local.rg}"
    length("local.subnets")
    format("rg-%s", "ander")
    upper("VaLo32")
    cidrsubnets("10.0.0.0/16", 8, 8)
    tolist(["a", "b", "c"])
    tomap({ name = "a"})
    ## aplicado a maps or objects
    merge(tomap({ name = "a"}), { valor = "${local.valor}" })
    min(2,85,-9,0)

exit
