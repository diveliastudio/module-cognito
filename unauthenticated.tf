resource "aws_iam_role" "unauthenticated" {
  name = "cognito-${var.project_name}-${var.project_environment}-role-unauthenticated"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.cognito.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "unauthenticated"
        }
      }
    }
  ]
}
EOF

  tags_all = {
    project = var.project_name
    environment = var.project_environment
  }
}

resource "aws_iam_role_policy" "unauthenticated" {
  name = "${var.project_name}-${var.project_environment}-unauthenticated-policy"
  role = aws_iam_role.unauthenticated.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "mobileanalytics:PutEvents",
          "cognito-sync:*"
        ]
        Resource = [
          "*"
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy" "s3_read_put_access" {
  name = "s3-read-put-access-${var.project_name}-${var.project_environment}-policy"
  role = aws_iam_role.unauthenticated.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "VisualEditor0"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.bucket_name}/*",
          "arn:aws:s3:::${var.bucket_name}"
        ]
      },
      {
        Sid = "VisualEditor1"
        Effect = "Allow"
        Action = [
          "s3:GetObjectAcl",
          "s3:PutObjectVersionAcl",
          "s3:PutObjectAcl"
        ]
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      },
      {
        Sid = "VisualEditor2"
        Effect = "Allow"
        Action = [
          "s3:GetObjectAcl",
          "s3:ListBucketVersions",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.bucket_name}/*",
          "arn:aws:s3:::${var.bucket_name}"
        ]
      }
    ]
  })
}
