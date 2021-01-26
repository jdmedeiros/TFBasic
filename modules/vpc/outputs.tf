output "aws_vpc_main_id" {
  description = "AWS vpc id. "
  value = aws_vpc.main.id
}

output "aws_subnet_top_id" {
  description = "AWS subnet top id. "
  value = aws_subnet.top.id
}

output "aws_subnet_bottom_id" {
  description = "AWS subnet bottom id. "
  value = aws_subnet.bottom.id
}
