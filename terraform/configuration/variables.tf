variable "github_organisation" {
  type        = string
  description = "The organisation to use for authenticating against Vault's GitHub auth method."
  default     = ""
}

variable "mount_path" {
  type        = string
  description = "The mount path to use for the default secrets engine."
  default     = "secret"
}
