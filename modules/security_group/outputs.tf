# The id of the security group
output "aws_security_group_id" {
  value       = aws_security_group.instance.id
}
