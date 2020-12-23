output "vault_mount_accessor" {
  value       = vault_mount.default.accessor
  description = "The accessor for the mounted default secrets engine."
}

output "vault_userpass_auth_accessor" {
  value       = vault_auth_backend.userpass.accessor
  description = "The accessor for the mounted userpass auth method."
}

output "vault_github_auth_accessor" {
  value       = vault_github_auth_backend.github.accessor
  description = "The accessor for the mounted GitHub auth method."
}
