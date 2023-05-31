resource "aws_lb" "mylb" {
  name = "${terraform.workspace}-mylb"
  security_groups = [aws_security_group.testsg.id]
  subnets = [
    data.aws_subnets.subnets_id.ids[0],
    data.aws_subnets.subnets_id.ids[1]
  ]
}
resource "aws_lb_target_group" "testtg" {
  name = "${terraform.workspace}-testtg"
  target_type = "instance"
  vpc_id = aws_default_vpc.default_vpc.id
  port = 80
  protocol = "HTTP"
  health_check {
    healthy_threshold = 5
    unhealthy_threshold = 3
    interval = 10
    timeout = 5
  }
}
resource "aws_lb_listener" "testlist" {
  load_balancer_arn = aws_lb.mylb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.testtg.arn
  }
}
