locals {
  prefix = "${var.system_name}-${var.system_env}"
  default_region = "ap-northeast-1"
  default_az = [
    "ap-northeast-1a",
    "ap-northeast-1c"
  ]
  policy_dir          = "../../modules/assetcompass/iam_policy_file/"
  lambda_dir          = "../../modules/assetcompass/lambda_scripts"
  task_dir            = "../../modules/assetcompass/container_definitions"
  bucket_policy_dir   = "../../modules/assetcompass/bucket_policy"
}
