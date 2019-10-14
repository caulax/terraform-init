resource "aws_lb_target_group" "golang" {
  name     = "golang-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}
