# 1. Define the REST API
resource "aws_api_gateway_rest_api" "movie_api" {
  name        = "MovieServiceAPI"
  description = "API to retrieve a list of movies"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# 2. Create the /movies resource
resource "aws_api_gateway_resource" "movies_resource" {
  rest_api_id = aws_api_gateway_rest_api.movie_api.id
  parent_id   = aws_api_gateway_rest_api.movie_api.root_resource_id
  path_part   = "movies"
}

# 3. Create the GET method for /movies
resource "aws_api_gateway_method" "get_movies" {
  rest_api_id   = aws_api_gateway_rest_api.movie_api.id
  resource_id   = aws_api_gateway_resource.movies_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# 4. Create the Mock Integration
# This allows the API to return data without a backend (Lambda/HTTP)
resource "aws_api_gateway_integration" "mock_integration" {
  rest_api_id = aws_api_gateway_rest_api.movie_api.id
  resource_id = aws_api_gateway_resource.movies_resource.id
  http_method = aws_api_gateway_method.get_movies.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

# 5. Define the Method Response (200 OK)
resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.movie_api.id
  resource_id = aws_api_gateway_resource.movies_resource.id
  http_method = aws_api_gateway_method.get_movies.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

# 6. Define the Integration Response
resource "aws_api_gateway_integration_response" "mock_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.movie_api.id
  resource_id = aws_api_gateway_resource.movies_resource.id
  http_method = aws_api_gateway_method.get_movies.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  response_templates = {
    "application/json" = file("${path.module}/data/movies.json")
  }

  depends_on = [aws_api_gateway_integration.mock_integration]
}

# 7. Deploy the API
resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.movie_api.id

  # Forces deployment to trigger when the configuration changes
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.movies_resource.id,
      aws_api_gateway_method.get_movies.id,
      aws_api_gateway_integration.mock_integration.id,
      aws_api_gateway_integration_response.mock_integration_response.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# 8. Create a stage
resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.movie_api.id
  stage_name    = "prod"
}
