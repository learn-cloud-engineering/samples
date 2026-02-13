resource "aws_api_gateway_rest_api" "movies_api" {
  name        = "MoviesApi"
  description = "An API that returns a list of movies."
}

resource "aws_api_gateway_resource" "movies_resource" {
  rest_api_id = aws_api_gateway_rest_api.movies_api.id
  parent_id   = aws_api_gateway_rest_api.movies_api.root_resource_id
  path_part   = "movies"
}

# GET method for /movies
resource "aws_api_gateway_method" "movies_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.movies_api.id
  resource_id   = aws_api_gateway_resource.movies_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "movies_get_integration" {
  rest_api_id = aws_api_gateway_rest_api.movies_api.id
  resource_id = aws_api_gateway_resource.movies_resource.id
  http_method = aws_api_gateway_method.movies_get_method.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{ \"statusCode\": 200 }"
  }
}

resource "aws_api_gateway_method_response" "movies_get_200" {
  rest_api_id = aws_api_gateway_rest_api.movies_api.id
  resource_id = aws_api_gateway_resource.movies_resource.id
  http_method = aws_api_gateway_method.movies_get_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "movies_get_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.movies_api.id
  resource_id = aws_api_gateway_resource.movies_resource.id
  http_method = aws_api_gateway_method.movies_get_method.http_method
  status_code = aws_api_gateway_method_response.movies_get_200.status_code

  response_templates = {
    "application/json" = jsonencode([
      { title = "The Shawshank Redemption" },
      { title = "The Godfather" },
      { title = "The Dark Knight" },
      { title = "Pulp Fiction" }
    ])
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'http://${aws_s3_bucket_website_configuration.site_website.website_endpoint}'"
  }
}

# OPTIONS method for CORS preflight
resource "aws_api_gateway_method" "movies_options_method" {
  rest_api_id   = aws_api_gateway_rest_api.movies_api.id
  resource_id   = aws_api_gateway_resource.movies_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "movies_options_integration" {
  rest_api_id = aws_api_gateway_rest_api.movies_api.id
  resource_id = aws_api_gateway_resource.movies_resource.id
  http_method = aws_api_gateway_method.movies_options_method.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{ \"statusCode\": 200 }"
  }
}

resource "aws_api_gateway_method_response" "movies_options_200" {
  rest_api_id = aws_api_gateway_rest_api.movies_api.id
  resource_id = aws_api_gateway_resource.movies_resource.id
  http_method = aws_api_gateway_method.movies_options_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "movies_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.movies_api.id
  resource_id = aws_api_gateway_resource.movies_resource.id
  http_method = aws_api_gateway_method.movies_options_method.http_method
  status_code = aws_api_gateway_method_response.movies_options_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'",
    "method.response.header.Access-Control-Allow-Origin"  = "'http://${aws_s3_bucket_website_configuration.site_website.website_endpoint}'"
  }
}
