data "template_file" "init" {
  template = file("scripts/init.sh")
  vars = {
    AWS_ACCESS_KEY   = var.AWS_ACCESS_KEY
    AWS_SECRET_KEY   = var.AWS_SECRET_KEY
    AWS_REGION       = var.AWS_REGION
  }
}

data "template_cloudinit_config" "init_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.init.rendered
  }
}
