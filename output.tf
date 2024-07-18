output "dns" {
  value = aws_route53_record.domain.name
}
# output "public_ip" {
#   value = aws_instance.rancher-server.public_ip
# }
output "ec2_public_dns" {
  value = aws_instance.rancher-server.public_dns

}
# output "key-name" {
#   value = aws_key_pair.tf-key-1.key_name # key_name is the terraform attribute for displaying key name of the key we are using..  ${aws_key_pair.tf-key-1.key_name}
# }
# output "securityGroupdetails" {
#   value = aws_security_group.allow_tls.id
# }
# output "instance_id_1st_machine" {
#   description = "ID of the 1st EC2 instance"
#   value       = aws_instance.ec2-by-terraform-1[0].id
# }
# output "instance_id_2nd_machine" {
#   description = "ID of the 2nd EC2 instance"
#   value       = aws_instance.ec2-by-terraform-1[1].id
# }
# output "instance_public_ip_1st_machine" {
#   description = "Public IP address of the 1st EC2 instance"
#   value       = aws_instance.ec2-by-terraform-1[0].public_ip
# }
# output "instance_public_ip_2nd_machine" {
#   description = "Public IP address of the 2nd EC2 instance"
#   value       = aws_instance.ec2-by-terraform-1[1].public_ip
# }