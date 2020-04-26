
resource "aws_iam_policy" "alb_ingress_controller_iam_policy" {
  name        = "${var.iam_policy_name_prefix}-EKSalbIngressControllerIamPolicy"
  path        = "/"
  description = "EKS ingress controller permissions"

  #https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/iam-policy.json
  policy = file("${path.module}/policies/alb_ingress_controller_iam_policy.json")
}

resource "aws_iam_role" "alb_ingress_controller_iam_role" {
  name = "${var.iam_policy_name_prefix}-EKSalbIngressControllerIamRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "alb_ingress_controller_policy_attachment" {
  policy_arn = aws_iam_policy.alb_ingress_controller_iam_policy.arn
  role       = aws_iam_role.alb_ingress_controller_iam_role.name
}

resource "helm_release" "ingress" {
  name       = "aws-alb-ingress-controller"
  repository = data.helm_repository.incubator.metadata[0].name
  chart      = "aws-alb-ingress-controller"
  namespace  = "kube-system"

  values = [<<EOF
  rbac:
    serviceAccount:
      annotations:
        eks.amazonaws.com/role-arn: ${aws_iam_role.alb_ingress_controller_iam_role.arn}
  EOF
  ]

  set {
    name  = "clusterName"
    value = var.clusterName
  }

  set {
    name  = "autoDiscoverAwsRegion"
    value = true
  }

  set {
    name  = "autoDiscoverAwsVpcID"
    value = true
  }
}