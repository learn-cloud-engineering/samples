# This resource creates a hash of the API configuration.
# When the configuration changes, the hash changes, which triggers a new deployment.
resource "null_resource" "api_definition_hash" {
  triggers = {
    definition = jsonencode({
      rest_api_id = aws_api_gateway_rest_api.movies_api.id
      resources   = [
        for r in aws_api_gateway_resource.movies_resource : r.id
      ]
      methods     = [
        for m in [aws_api_gateway_method.movies_get_method, aws_api_gateway_method.movies_options_method] : m.id
      ]
      integrations = [
        for i in [aws_api_gateway_integration.movies_get_integration, aws_api_gateway_integration.movies_options_integration] : i.id
      ]
    })
  }
}

resource "aws_api_gateway_deployment" "movies_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.movies_api.id

  # This tells Terraform that this deployment depends on the API methods and integrations.
  # The 'triggers' block with the hash ensures a new deployment is created on change.
  triggers = {
    redeployment = null_resource.api_definition_hash.id
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.movies_api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.movies_api.id
  stage_name    = "prod"
}
