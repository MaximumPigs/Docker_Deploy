resource "aws_cloudwatch_metric_alarm" "no_players" {
  alarm_name          = "No Players ${var.environment} ${var.game}"
  namespace           = "AWS/EC2"
  metric_name         = "NetworkPacketsOut"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  period              = "10"
  statistic           = "Average"
  threshold           = "5000"

  alarm_actions = ["arn:aws:automate:${data.aws_region.current.name}:ec2:terminate"]

  dimensions = {
    InstanceId = aws_instance.my_instance.id
  }
}

resource "aws_cloudwatch_metric_alarm" "unreachable" {
  alarm_name          = "Unreachable ${var.environment} ${var.game}"
  namespace           = "AWS/EC2"
  metric_name         = "StatusCheckFailed_System"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  period              = "10"
  statistic           = "Average"
  threshold           = "2"

  alarm_actions = [
    "arn:aws:automate:${data.aws_region.current.name}:ec2:recover"
  ]

  dimensions = {
    InstanceId = aws_instance.my_instance.id
  }
}