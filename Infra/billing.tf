resource "aws_ce_cost_allocation_tag" "game_servers" {
  tag_key = "game_servers"
  status  = "Active"
}

resource "aws_ce_cost_allocation_tag" "game" {
  tag_key = var.game
  status  = "Active"
}