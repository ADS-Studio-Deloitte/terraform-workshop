module "table" {
  source      = "../../../../modules/dynamodb-table-module"
  environment = var.environment
  region      = var.region
  resource    = var.resource
  tags        = var.tags
  project     = var.project

  special_name = var.table_name
}