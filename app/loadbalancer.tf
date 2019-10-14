resource "aws_lb" "golang" {
  name = "golang"
  subnets = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  security_groups = [aws_security_group.allow-ssh.id]
}

resource "aws_lb_listener" "golang" {
  load_balancer_arn = "${aws_lb.golang.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
      target_group_arn = aws_lb_target_group.golang.arn
      type = "forward"
  }
}

resource "aws_route53_zone" "main" {
  name = "test.dev.externalone.com"
}

resource "aws_route53_zone" "golang" {
  name = "golang.test.dev.externalone.com"

  tags = {
    Environment = "golang"
  }

  vpc {
    vpc_id = "${aws_vpc.main.id}"
  }

  lifecycle {
    ignore_changes = ["vpc"]
  }
}

resource "aws_route53_record" "golang-ns" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "golang.test.dev.externalone.com"
  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.golang.name_servers.0}",
    "${aws_route53_zone.golang.name_servers.1}",
    "${aws_route53_zone.golang.name_servers.2}",
    "${aws_route53_zone.golang.name_servers.3}",
  ]
}
