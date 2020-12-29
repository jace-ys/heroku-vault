terraform {
  required_version = ">= 0.14"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.17"
    }
  }
}

provider "vault" {}

resource "vault_audit" "default" {
  type = "file"

  options = {
    file_path = "stdout"
  }
}

resource "vault_mount" "default" {
  path = var.mount_path
  type = "kv-v2"
}

resource "vault_policy" "admin" {
  name = "admin"

  policy = templatefile("${path.module}/policies/admin.tmpl", {
    mount_path = var.mount_path,
  })
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_github_auth_backend" "github" {
  organization   = var.github_organisation
  token_policies = [vault_policy.admin.name]
}

resource "vault_generic_endpoint" "userpass_admin" {
  count = var.admin_username != null && var.admin_password != null ? 1 : 0

  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/${var.admin_username}"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "password": "${var.admin_password}",
  "policies": ["${vault_policy.admin.name}"]
}
EOT
}
