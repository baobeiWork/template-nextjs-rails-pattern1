# 
# for GitHubActions Uesr 
# 
#resource "aws_iam_policy" "github_actions" {
#  name        = "${local.prefix}-Github-Actions"
#  description = "for github Actions"
#  policy      = file("${local.policy_dir}/github_actions.json")
#}

# 
# for Operation Uesr 
# 
#resource "aws_iam_policy" "operation_user" {
#  name        = "${local.prefix}-Operation-User"
#  description = "for Operation User"
#  policy      = file("${local.policy_dir}/operation_user.json")
#}

# 
# S3
# 
resource "aws_iam_policy" "s3_bucket_policy" {
  name        = "${local.prefix}-s3-bucket-policy"
  description = "IAM policy to allow S3 bucket policy management"
  policy      = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Action": [
            "s3:PutBucketPolicy",
            "s3:GetBucketPolicy",
            "s3:DeleteBucketPolicy"
        ],
        "Resource": "arn:aws:s3:::*"
        }
    ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "s3_bucket_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.s3_bucket_policy.arn
}



