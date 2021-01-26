variable "instance_name" {
  type    = string
  default = "ubuntudsk"
}

variable "key_name" {
  type    = string
  default = "GRSI-KEY"
}

variable "volume_size" {
  type    = number
  default = 30
}

variable "security_group_name" {
  type    = string
  default = "Ubuntu Desktop security group"
}

variable "cloud_config" {
  type    = string
  default = "cloud-config.sh"
}

# Firewall rules
variable "ingress_fw_rules" {
  description = "Firewall rules"
  #                  Protocol [-1 for all traffic] or tcp, udp, etc.
  #                  |       From port [0 for all ports]
  #                  |       |       To port [0 for all ports]
  #                  |       |       |       Description
  #                  |       |       |       |       Link to ip_list entry
  #                  |       |       |       |       |
  type = list(tuple([string, number, number, string, number]))
  default = [
    [-1, 0, 0, "Allow all traffic from the public address of the administrator", 0],
    ["tcp", 80, 80, "Allow HTTP traffic from RFC1918", 1],

  ]
}

# The list of IPs to associate with each firewall rule. Association is made based on the "Link to ip_list entry" field
variable "ingress_ip_list" {
  description = "Allowed IPs"
  type        = list(list(string))
  default = [
    ["128.65.243.205/32"],
    ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"],
  ]
}


variable "bucket_name" {
  description = "The name of the S3 bucket to store the state. Must be globally unique."
  type        = string
  default     = "jdmedeiros-TFProjects-tfstate"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default     = "jdmedeiros-tfprojects-tfstate-lock"
}

variable "vpc_name" {
  default = "grsi"
}

variable "vpc_cidr_block" {
  default = "172.26.0.0/16"
}

variable "public_subnets" {
  default = ["172.26.0.0/24"]
}

variable "private_subnets" {
  default = ["172.26.1.0/24"]
}


variable "top_server_instance_private_ip" {
  default = "172.26.0.10"
}

variable "bottom_server_instance_private_ip" {
  default = "172.26.1.10"
}

variable "client_instance_private_ip" {
  default = "172.26.1.11"
}

variable "server_instance_name" {
  type = string
  default = "ubuntusrv"
}
