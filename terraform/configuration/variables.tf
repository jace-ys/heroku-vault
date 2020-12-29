variable "mount_path" {
  type        = string
  description = "The mount path to use for the default secrets engine."
  default     = "secret"
}

variable "github_organisation" {
  type        = string
  description = "The organisation to use for authenticating against Vault's GitHub auth method."
  default     = ""
}

variable "admin_username" {
  type        = string
  description = "The username of the admin user to create using the userpass auth method."
  default     = null
}

variable "admin_password" {
  type        = string
  description = "The password of the admin user to create using the userpass auth method."
  default     = null
  sensitive   = true
}
