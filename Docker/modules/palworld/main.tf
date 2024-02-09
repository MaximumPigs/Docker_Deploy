resource "docker_image" "image" {
  name = "jammsen/palworld-dedicated-server:latest"
}

resource "docker_container" "container" {
  name  = "palworld"
  image = docker_image.image.image_id

  ports {
    internal = 8211
    external = 8211
    protocol = "udp"
  }

  ports {
    internal = 25575
    external = 25575
    protocol = "tcp"
  }

  env = [
    # Server Settings
    "SERVER_SETTINGS_MODE=auto",
    "ALWAYS_UPDATE_ON_START=true",
    "STEAMCMD_VALIDATE_FILES=true",
    "MAX_PLAYERS=10",
    "MULTITHREAD_ENABLED=true",
    "COMMUNITY_SERVER=false",
    "RCON_ENABLED=false",
    "RCON_PORT=25575",
    "PUBLIC_IP=${var.instance_ip}",
    "PUBLIC_PORT=8211",
    "SERVER_NAME=${var.server_name}",
    "SERVER_DESCRIPTION=BroPals, Bro",
    "ADMIN_PASSWORD=${var.server_password}!",
    "SERVER_PASSWORD=${var.server_password}",
    "WEBHOOK_ENABLED=${local.discord_webhook_enable}",
    "WEBHOOK_URL=${var.discord_webhook}",
    "WEBHOOK_START_TITLE=Server is up",
    "WEBHOOK_START_DESCRIPTION=The gameserver is up, at ${var.instance_ip}:8211, join now with password ${var.server_password}",
    "BACKUP_ENABLED=true",
    "BACKUP_CRON_EXPRESSION=0 * * * * ",
    "BACKUP_RETENTION_POLICY=true",
    "BACKUP_RETENTION_AMOUNT_TO_KEEP=10",
    # Game Settings
    "NETSERVERMAXTICKRATE=120",
    "DIFFICULTY=None",
    "DAYTIME_SPEEDRATE=1",
    "NIGHTTIME_SPEEDRATE=1",
    "EXP_RATE=1",
    "PAL_CAPTURE_RATE=1",
    "PAL_SPAWN_NUM_RATE=1",
    "PAL_DAMAGE_RATE_ATTACK=1",
    "PAL_DAMAGE_RATE_DEFENSE=1",
    "PLAYER_DAMAGE_RATE_ATTACK=1",
    "PLAYER_DAMAGE_RATE_DEFENSE=1",
    "PLAYER_STOMACH_DECREASE_RATE=1",
    "PLAYER_STAMINA_DECREACE_RATE=1",
    "PLAYER_AUTO_HP_REGENE_RATE=1",
    "PLAYER_AUTO_HP_REGENE_RATE_IN_SLEEP=1",
    "PAL_STOMACH_DECREACE_RATE=1",
    "PAL_STAMINA_DECREACE_RATE=1",
    "PAL_AUTO_HP_REGENE_RATE=1",
    "PAL_AUTO_HP_REGENE_RATE_IN_SLEEP=1",
    "BUILD_OBJECT_DAMAGE_RATE=1",
    "BUILD_OBJECT_DETERIORATION_DAMAGE_RATE=1",
    "COLLECTION_DROP_RATE=1",
    "COLLECTION_OBJECT_HP_RATE=1",
    "COLLECTION_OBJECT_RESPAWN_SPEED_RATE=1",
    "ENEMY_DROP_ITEM_RATE=1",
    "DEATH_PENALTY=ItemAndEquipment",
    "ENABLE_PLAYER_TO_PLAYER_DAMAGE=FALSE",
    "ENABLE_FRIENDLY_FIRE=FALSE",
    "ENABLE_INVADER_ENEMY=FALSE",
    "ACTIVE_UNKO=FALSE",
    "ENABLE_AIM_ASSIST_PAD=TRUE",
    "ENABLE_AIM_ASSIST_KEYBOARD=FALSE",
    "DROP_ITEM_MAX_NUM=3000",
    "DROP_ITEM_MAX_NUM_UNKO=100",
    "BASE_CAMP_MAX_NUM=128",
    "BASE_CAMP_WORKER_MAXNUM=15",
    "DROP_ITEM_ALIVE_MAX_HOURS=1",
    "AUTO_RESET_GUILD_NO_ONLINE_PLAYERS=FALSE",
    "AUTO_RESET_GUILD_TIME_NO_ONLINE_PLAYERS=72",
    "GUILD_PLAYER_MAX_NUM=20",
    "PAL_EGG_DEFAULT_HATCHING_TIME=12",
    "WORK_SPEED_RATE=1",
    "IS_MULTIPLAY=FALSE",
    "IS_PVP=FALSE",
    "CAN_PICKUP_OTHER_GUILD_DEATH_PENALTY_DROP=FALSE",
    "ENABLE_NON_LOGIN_PENALTY=FALSE",
    "ENABLE_FAST_TRAVEL=TRUE",
    "IS_START_LOCATION_SELECT_BY_MAP=TRUE",
    "EXIST_PLAYER_AFTER_LOGOUT=FALSE",
    "ENABLE_DEFENSE_OTHER_GUILD_PLAYER=FALSE",
    "COOP_PLAYER_MAX_NUM=4",
    "REGION=",
    "USEAUTH=TRUE",
    "BAN_LIST_URL=https://api.palworldgame.com/api/banlist.txt",
  ]

  mounts {
    type   = "bind"
    target = "/palworld"
    source = "/data"
  }
}