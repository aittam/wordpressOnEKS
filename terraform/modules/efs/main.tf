resource "aws_efs_file_system" "this" {
  encrypted                       = var.encrypted
  kms_key_id                      = var.kms_key_id
  performance_mode                = var.performance_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  throughput_mode                 = var.throughput_mode

  tags = merge(
                {
                  "Name" = var.name
                },
                var.tags
              )
}

resource "aws_efs_mount_target" "default" {
  count           = length(var.subnets) > 0 ? length(var.subnets) : 0
  file_system_id  = join("", aws_efs_file_system.this.*.id)
  subnet_id       = var.subnets[count.index]
  security_groups = [join("", aws_security_group.efs.*.id)]
}

resource "aws_security_group" "efs" {
  name        = format("%s-efs", var.name)
  description = "EFS Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.ingress_sg_cidr_blocks
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}


resource "helm_release" "efs-provisioner" {
  name       = "efs-provisioner"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "efs-provisioner"

  values = [<<EOF
  efsProvisioner:
    efsFileSystemId: ${aws_efs_file_system.this.id}
    awsRegion: ${data.aws_region.current.name}
    path: /${var.name}
    provisionerName: ${var.name}/aws-efs
    storageClass:
      name: aws-efs
      gidAllocate:
        enabled: false
  EOF
  ]
}
