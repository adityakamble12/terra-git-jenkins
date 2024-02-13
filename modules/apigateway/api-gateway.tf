# Create REST API
resource "aws_api_gateway_rest_api" "rest_api" {
  name        = var.api_name
  description = var.api_description

  endpoint_configuration {
    types = [var.endpoint_type]
  }
}

# Create WebSocket API
resource "aws_apigatewayv2_api" "wsapi" {
  name                       = var.api_name_2
  description                = var.api_description_2
  protocol_type              = var.protocol_type
  route_selection_expression = var.route_selection_expression
  version                    = var.api_version
}
