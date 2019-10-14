output "alb-link" {
  value = [aws_lb.golang.dns_name]
}

