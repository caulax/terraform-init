resource "aws_launch_configuration" "golang-launchconfig" {
  name_prefix     = "golang-launchconfig"
  image_id        = "ami-0cc0a36f626a4fdf5"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.allow-ssh.id]
  user_data = data.template_cloudinit_config.init_config.rendered
}

resource "aws_autoscaling_group" "golang-autoscaling" {
  name                      = "golang-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-1.id]
  launch_configuration      = aws_launch_configuration.golang-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.golang.arn]

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}
