resource "aws_iam_user" "ecs-iam" {
  name = "${var.projeto}-iam"
  tags = var.tags

}

resource "aws_iam_access_key" "ecs-key" {
  user = aws_iam_user.ecs-iam.name
}

data "aws_iam_policy_document" "ecs_ro" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "ecs_ro" {
  name   = "${var.projeto}-iam-policy"
  user   = aws_iam_user.ecs-ia.name
  policy = data.aws_iam_policy_document.ecs-ro.json
}

output "key-iam" {
    value = aws_iam_access_key.ecs-key.id
  }