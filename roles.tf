resource "aws_cognito_identity_pool_roles_attachment" "cognito_roles" {
  identity_pool_id = aws_cognito_identity_pool.cognito.id

  roles = {
    "authenticated" = aws_iam_role.authenticated.arn,
    "unauthenticated" = aws_iam_role.unauthenticated.arn
  }
}