terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = var.github_token
}

locals {
  repo_config = yamldecode(file("${path.module}/repo_config.yaml"))
}

resource "github_repository" "repo" {
  name        = local.repo_config.name
  description = local.repo_config.description
  visibility  = local.repo_config.visibility

  dynamic "features" {
    for_each = local.repo_config.features
    content {
      name    = features.key
      enabled = features.value
    }
  }

  dynamic "settings" {
    for_each = local.repo_config.settings
    content {
      name  = settings.key
      value = settings.value
    }
  }

  topics = local.repo_config.topics
}
