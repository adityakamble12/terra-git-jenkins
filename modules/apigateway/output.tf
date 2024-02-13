
output "rest_api_id" {
  value = aws_api_gateway_rest_api.rest_api.id
}

output "websocket_api_id" {
  value = aws_apigatewayv2_api.wsapi.id
}

output "websocket_api_endpoint" {
  value = aws_apigatewayv2_api.wsapi.api_endpoint
}
