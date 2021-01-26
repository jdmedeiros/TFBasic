# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "instance" {
  vpc_id = var.vpc_id == null ? data.aws_vpc.default.id : var.vpc_id
  name   = var.security_group_name

  # This should be converted to a separate aws_security_group_rule resource ASAP
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description = ""
      from_port = 0
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "-1"
      security_groups = []
      self = false
      to_port = 0
    },
  ]

  # This should be converted to a separate aws_security_group_rule resource ASAP
  ingress = [
  for _fw_rule in var.ingress_fw_rules:
  {
    cidr_blocks = [
    for _ip in var.ingress_ip_list[_fw_rule[4]]:
    _ip
    ]
    description = _fw_rule[3]
    from_port = _fw_rule[1]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = _fw_rule[0]
    security_groups = []
    self = false
    to_port = _fw_rule[2]
  }
  ]
}