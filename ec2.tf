resource "aws_instance" "testec2" {
  ami = var.ami_id
  instance_type = var.ins_type
  vpc_security_group_ids = [aws_security_group.testsg.id]
  iam_instance_profile = "ecsInstanceRole"
  subnet_id = data.aws_subnets.subnets_id.ids[0]
  user_data = <<EOF
#!/bin/bash
sleep 2
apt update
apt install docker.io --yes
docker pull amazon/amazon-ecs-agent:latest
docker run --name ecs-agent \
--detach=true \
--net=host \
--volume=/var/run/docker.sock:/var/run/docker.sock \
--volume=/var/log/ecs/:/log \
--publish=127.0.0.1:51678:51678 \
--volume=/var/lib/ecs/data:/data \
--env=ECS_LOGFILE=/log/ecs-agent.log \
--env=ECS_LOGLEVEL=info \
--env=ECS_ENABLE_CONTAINER_METADATA=true \
--env=ECS_DATADIR=/data \
--env=ECS_CLUSTER=TESTING \
amazon/amazon-ecs-agent:latest
EOF
  tags = {
    name = "${terraform.workspace}_myec2"
  }
}
