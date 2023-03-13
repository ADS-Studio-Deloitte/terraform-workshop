module "backend" {
  source = "../../../../modules/aws-backend-module"

  bucket-prefix = var.project
  environment   = var.environment
  region        = var.region
  resource = var.resource
  tags          = var.tags
}