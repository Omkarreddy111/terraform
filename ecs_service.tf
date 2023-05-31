
resource "aws_ecs_service" "ECS_Service" {
  name = "nginxservice"
  cluster = aws_ecs_cluster.cluster.name
  task_definition = aws_ecs_task_definition.service.arn
  desired_count = 1
  iam_role = "arn:aws:iam::521593486826:role/ecsServiceRole"
  health_check_grace_period_seconds = 300
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 50
  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.testtg.arn
    container_name   = "nginx"
    container_port   = 80
  }
  depends_on = [aws_lb_listener.testlist]
}