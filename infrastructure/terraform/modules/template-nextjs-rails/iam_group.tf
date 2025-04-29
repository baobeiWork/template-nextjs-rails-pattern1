# 
# for Operation Uesr 
# 
#resource "aws_iam_group" "operation_user_group" {
#  name = "${local.prefix}-Operation-User-Group"
#}

#resource "aws_iam_group_policy_attachment" "operation_user_policy_attachment" {
#  group      = aws_iam_group.operation_user_group.name
#  policy_arn = aws_iam_policy.operation_user.arn
#
#  depends_on = [
#    aws_iam_policy.operation_user,
#    aws_iam_group.operation_user_group
# ]
#}