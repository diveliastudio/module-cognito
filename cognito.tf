resource "aws_cognito_identity_pool" "cognito" {
  identity_pool_name = "cognito-${var.project_name}-${var.project_environment}"
  allow_unauthenticated_identities = var.allow_unauthenticated_identities
  allow_classic_flow = var.allow_classic_flow


  tags_all = {
    project = var.project_name
    environment = var.project_environment
  }
}

resource "local_file" "id_cognito_pool" {
  filename = "cognito/${var.project_name}_${var.project_environment}_id_cognito_pool.txt"
  content = aws_cognito_identity_pool.cognito.id
}
