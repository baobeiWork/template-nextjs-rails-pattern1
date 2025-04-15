/* # 
# for Github Actions 
# 
resource "aws_iam_user" "github_actions_user" {
  name = "${local.prefix}-github-actions"
}
resource "aws_iam_user_policy_attachment" "github_actions_user_policy_attachment" {
  user       = aws_iam_user.github_actions_user.name
  policy_arn = aws_iam_policy.github_actions.arn
}


# 
# for Operation Uesr 
# 
resource "aws_iam_user" "operation_user" {
  for_each = toset(var.operation_users)
  name     = each.value
}
resource "aws_iam_group_membership" "operation_user_group_membership" {
  name  = "${local.prefix}-Operation-User-Group-Membership"
  group = aws_iam_group.operation_user_group.name
  users = [for user in aws_iam_user.operation_user : user.name]

  depends_on = [
    aws_iam_user.operation_user,
    aws_iam_group.operation_user_group
  ]
} */