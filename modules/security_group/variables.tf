# VPC id for the security group
variable "vpc_id" {
  type    = string
  default = null
}

# Name for the security group
variable "security_group_name" {
  type    = string
  default = "Default name for the security group"
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
  ]
}

# The list of IPs to associate with each firewall rule. Association is made based on the "Link to ip_list entry" field
variable "ingress_ip_list" {
  description = "Allowed IPs"
  type        = list(list(string))
  default = [
    ["127.0.0.1/32"],
  ]
}

variable "security_group_bucket_name" {
  description = "The name of the S3 bucket to store the state."
  type        = string
  default     = ""
}

variable "security_group_bucket_key_name" {
  description = "The name of the S3 bucket folder to store the state."
  type        = string
  default     = ""
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default     = ""
}

