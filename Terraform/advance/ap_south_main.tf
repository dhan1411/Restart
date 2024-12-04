
resource "aws_instance" "Machine1" {
  provider = aws.ap-south
  for_each = local.configuration1

  ami     = "ami-03753afda9b8ba740"
  instance_type = each.value.instance_type
  tags = each.value.tags

}

resource "aws_instance" "Machine2" {
  provider = aws.us-east
  for_each = local.configuration2

  ami     = "ami-088d38b423bff245f"
  instance_type = each.value.instance_type
  tags = each.value.tags

}