data "http" "endpoint" {
  url        = "${aws_api_gateway_stage.prod.invoke_url}/movies"
  depends_on = [aws_api_gateway_stage.prod]

  retry {
    attempts     = 5
    min_delay_ms = 5000
  }
}
