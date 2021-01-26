module "vpc" {
  source = "../../modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  top_cidr_block = var.top_cidr_block
  bottom_cidr_block = var.bottom_cidr_block
  vpc_bucket_name = var.bucket_name
  vpc_bucket_key_name = "env-production/server/vpc"
  dynamodb_table_name = var.dynamodb_table_name
}

module "security_group" {
  source = "../../modules/security_group"
  security_group_name = "Server security group"
  security_group_bucket_name = var.bucket_name
  security_group_bucket_key_name = "env-production/server/server_security_group"
  dynamodb_table_name = var.dynamodb_table_name
  ingress_fw_rules = var.ingress_fw_rules
  ingress_ip_list = var.ingress_ip_list
  vpc_id = module.vpc.aws_vpc_main_id
}


resource "aws_network_interface" "server_top" {
  description = "Primary network interface"
  private_ip = var.top_server_instance_private_ip
  private_ips = [
    var.top_server_instance_private_ip,
  ]
  security_groups = [
    module.security_group.aws_security_group_id,
  ]
  subnet_id = module.vpc.aws_subnet_top_id
  source_dest_check = false
}

resource "aws_network_interface" "server_bottom" {
  description = "Secondary network interface"
  private_ip = var.bottom_server_instance_private_ip
  private_ips = [
    var.bottom_server_instance_private_ip,
  ]
  security_groups = [
    module.security_group.aws_security_group_id,
  ]
  subnet_id = module.vpc.aws_subnet_bottom_id
  source_dest_check = false
}

resource "aws_instance" "instance0" {
  ami = "ami-0885b1f6bd170450c"
  instance_type = "t2.micro"
  key_name = var.key_name

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.server_top.id
  }

  network_interface {
    device_index = 1
    network_interface_id = aws_network_interface.server_bottom.id
  }

  tags = {
    "Name" = var.server_instance_name
  }

  root_block_device {
    volume_size = var.volume_size
  }
#  user_data = data.template_cloudinit_config.config-server.rendered

}

# Elastic IP
resource "aws_eip" "instance0_eip" {
  vpc = true
}

resource "aws_eip_association" "instance0_eip_assoc" {
  network_interface_id = aws_network_interface.server_top.id
  allocation_id = aws_eip.instance0_eip.id
}
