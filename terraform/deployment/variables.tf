variable "heroku_app" {
  type        = string
  description = "Name of the Heroku app."
}

variable "heroku_domain" {
  type        = string
  description = "Custom domain for the Heroku app."
  default     = null
}

variable "vault_auto_unseal" {
  type        = bool
  description = "Flag to auto-unseal Vault whenever the server restarts."
  default     = true
}

variable "vault_unseal_key" {
  type        = string
  description = "Key for unsealing Vault whenever the server restarts."
  default     = null
  sensitive   = true
}
