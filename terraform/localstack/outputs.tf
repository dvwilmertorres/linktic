#*
output "webserver" {
  value = aws_instance.web.public_dns
}
output "MyPostgresDB" {
  value = aws_instance.web.public_dns
}
#output "mongodb_public_dns" {
#value = aws_instance.mongodb.public_dns
#}

#output "nodejs_public_ip" {
#  value = aws_instance.nodejs.public_ip
#}

#output "nodejs_public_dns" {
#  value = aws_instance.nodejs.public_dns
#}

#output "nginx_public_ip" {
#  value = aws_instance.nginx.public_ip
#}
#
#output "nginx_public_dns" {
#  value = aws_instance.nginx.public_dns
#}
