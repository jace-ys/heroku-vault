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
