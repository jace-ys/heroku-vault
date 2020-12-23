output "heroku_app_url" {
  value       = heroku_app.default.web_url
  description = "The URL of the Heroku app."
}

output "heroku_domain_cname" {
  value       = var.heroku_domain != null ? heroku_domain.default[0].cname : null
  description = "The DNS target for the custom Heroku domain."
}
