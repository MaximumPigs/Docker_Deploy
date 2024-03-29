locals {
  games = {
    palworld = {
      name = "palworld"
      vm_size = {
        default = {
          type   = "m6a.large"
          memory = 8
        },
        large = {
          type   = "r6a.large"
          memory = 16
        }
      }
      disk_size = "18"
      swap_size = "8"
      # Directory path containing save files relative to container mount root. Will backup and restore all contents recursively. Separate multiple values by space. If left blank whole /data folder will be backed up.
      save_dirs = "Pal/Saved/SaveGames/"
      # Single save file path relative to container mount root. Will backup and restore these single files. Separate multiple values by space.
      save_files = "Pal/Saved/Config/LinuxServer/GameUserSettings.ini"
      ports = [
        {
          index      = "1" # This is required as a unique key to use in the for_each loop
          start_port = "8211"
          end_port   = "8211"
          protocol   = "UDP"
        }
      ]
    },
    enshrouded = {
      name = "enshrouded"
      vm_size = {
        default = {
          type   = "m6a.large"
          memory = 8
        },
        large = {
          type   = "r6a.large"
          memory = 16
        }
      }
      disk_size = "45"
      swap_size = "8"
      # Directory path containing save files relative to container mount root. Will backup and restore all contents recursively. Separate multiple values by space. If left blank whole /data folder will be backed up.
      save_dirs = ""
      # Single save file path relative to container mount root. Will backup and restore these single files. Separate multiple values by space.
      save_files = ""
      ports = [
        {
          index      = "1" # This is required as a unique key to use in the for_each loop
          start_port = "15636"
          end_port   = "15637"
          protocol   = "UDP"
        },
        {
          index      = "2" # This is required as a unique key to use in the for_each loop
          start_port = "15636"
          end_port   = "15637"
          protocol   = "TCP"
        }
      ]
    }
  }
}