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

variable "vault_init_secret_key" {
  type        = string
  description = "The 32-byte secret key to be used by vault-init for encrypting root tokens and unseal keys."
  sensitive   = true
}
