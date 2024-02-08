locals {
  games = {
    palworld = {
      name      = "palworld"
      vm_size   = "m6a.large"
      disk_size = "18"
      # Directories containing save files beneath the /data directory. Will backup and restore all contents recursively. Separate multiple values by space. If left blank whole /data folder will be backed up.
      save_dirs = "Pal/Saved/SaveGames/"
      # Single save files beneath the /data directory. Will backup and restore these single files. Separate multiple values by space.
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
      name      = "enshrouded"
      vm_size   = "m6a.large"
      disk_size = "44"
      # Directories containing save files beneath the /data directory. Will backup and restore all contents recursively. Separate multiple values by space. If left blank whole /data folder will be backed up.
      save_dirs = ""
      # Single save files beneath the /data directory. Will backup and restore these single files. Separate multiple values by space.
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