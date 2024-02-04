locals {
  games = {
    palworld = {
      name      = "palworld"
      vm_size   = "t2.xlarge"
      disk_size = "10"
    },
    enshrouded = {
      name      = "enshrouded"
      vm_size   = "t2.xlarge"
      disk_size = "40"
    }
  }
}