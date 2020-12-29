data "heroku_app" "default" {
  name = heroku_app.default.id
}

output "heroku_app_url" {
  value       = heroku_app.default.web_url
  description = "The URL of the Heroku app."
}

output "heroku_database_url" {
  value       = lookup(data.heroku_app.default.config_vars, "DATABASE_URL", "not found")
  description = "The URL of the database associated with the Heroku app."
}

output "heroku_domain_cname" {
  value       = var.heroku_domain != null ? heroku_domain.default[0].cname : null
  description = "The DNS target for the custom Heroku domain."
}
