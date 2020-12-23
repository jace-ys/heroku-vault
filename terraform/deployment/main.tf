terraform {
  required_version = ">= 0.14"

  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 3.2"
    }
  }
}

provider "heroku" {}

resource "heroku_app" "default" {
  name   = var.heroku_app
  region = "eu"
  stack  = "container"

  config_vars = {
    VAULT_AUTO_UNSEAL = var.vault_auto_unseal
    VAULT_UNSEAL_KEY  = var.vault_unseal_key
  }
}

resource "heroku_addon" "database" {
  app  = heroku_app.default.id
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_domain" "default" {
  count = var.heroku_domain != null ? 1 : 0

  app      = heroku_app.default.id
  hostname = var.heroku_domain
}

resource "heroku_build" "default" {
  app = heroku_app.default.id

  source = {
    path = "heroku-vault.tar.gz"
  }
}

resource "heroku_formation" "default" {
  app      = heroku_app.default.id
  type     = "web"
  quantity = 1
  size     = "Free"

  depends_on = [heroku_build.default]
}
