
variable "api_name" {
  description = "Name of the REST API"
  type        = string
}

variable "api_description" {
  description = "Description of the REST API"
  type        = string
}

variable "endpoint_type" {
  description = "Type of endpoint for the REST API"
  type        = string
}

variable "api_name_2" {
  description = "Name of the WebSocket API"
  type        = string
}

variable "api_description_2" {
  description = "Description of the WebSocket API"
  type        = string
}

variable "protocol_type" {
  description = "Protocol type for the WebSocket API"
  type        = string
}

variable "route_selection_expression" {
  description = "Route selection expression for the WebSocket API"
  type        = string
}

variable "api_version" {
  description = "Version of the WebSocket API"
  type        = string
}
