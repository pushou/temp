// variables that can be overriden

variable "vm_name" {
  type = list(object({
    number  = string,
    name    = string,
    machine = string,
    memory  = string,
  }))
  default = [
    {
      number  = "01"
      name    = "asterix"
      machine = "q35"
      memory  = "2048"
    },
    {
      number  = "02"
      name    = "obelix"
      machine = "q35"
      memory  = "2048"
    },
    {
      number  = "03"
      name    = "idefix"
      machine = "q35"
      memory  = "2048"
    }
  ]
}

