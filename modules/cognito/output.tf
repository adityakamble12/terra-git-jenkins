
output "userpool_id" {
  value = aws_cognito_user_pool.userpool.id
}

output "client_id" {
  value = aws_cognito_user_pool_client.userpool_client.id
}
