#*
output "webserver" {
  value = aws_instance.web.public_dns
}
output "MyPostgresDB" {
  value = aws_instance.web.public_dns
}
output "user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
}
#output "user_pool_client_secret" {
#  value = aws_cognito_user_pool_client.user_pool_client.client_secret
#}