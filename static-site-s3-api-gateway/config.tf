resource "local_file" "api_config_js" {
  content  = "export const apiUrl = '${aws_api_gateway_stage.prod.invoke_url}';"
  filename = "${path.module}/site/config.js"
}
