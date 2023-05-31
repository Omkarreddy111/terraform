output "instance_public_dns" {
  value = aws_instance.testec2.public_ip
}
output "lb_public_dns" {
  value = aws_lb.mylb.dns_name
}