# AWS Cognito Terraform module

## Usage

```hcl
provider "aws" {
  region = "us-east-2"
  profile = "project"
}

module "s3_bucket" {
  ...
}

module "aws_cognito" {
  source  = "github.com/diveliastudio/module-cognito"
  project_name = "project"
  project_environment = "develop"
  bucket_name = module.s3_bucket.bucket_name # module.<name_module_s3>.<output_bucket_name>
}
```

**Note:** The `output_bucket_name` value will be the s3 `bucket name` value that will be `output`. You can also put the name of the bucket directly.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_name | Project's name | `string` | `""` | yes |
| project_environment | Project environment | `string` | `""` | yes |
| bucket_name | Name of the bucket to relate. | `string` | `""` | yes |
| allow_unauthenticated_identities | Whether the identity pool supports unauthenticated logins or not. | `bool` | `true` | no |
| allow_classic_flow | Enables or disables the classic / basic authentication flow. | `bool` | `false` | no |


## Resources that return

| Extension | Folder | Description |
|------|-------------|:--------:|
| id_cognito_pool.txt | ./cognito | Text file with Access Id to cognito pool |
