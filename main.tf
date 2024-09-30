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
  repo_config = yamldecode(file("${path.module}/data/repos/repo_config.yaml"))
}

resource "github_repository" "repo" {
  name        = local.repo_config.name
  description = local.repo_config.description
  visibility  = local.repo_config.visibility

  has_issues      = local.repo_config.features.has_issues
  has_projects    = local.repo_config.features.has_projects
  has_wiki        = local.repo_config.features.has_wiki
  has_downloads   = local.repo_config.features.has_downloads
  has_discussions = local.repo_config.features.has_discussions

  allow_merge_commit     = local.repo_config.settings.allow_merge_commit
  allow_squash_merge     = local.repo_config.settings.allow_squash_merge
  allow_rebase_merge     = local.repo_config.settings.allow_rebase_merge
  allow_auto_merge       = local.repo_config.settings.allow_auto_merge
  delete_branch_on_merge = local.repo_config.settings.delete_branch_on_merge
  auto_init              = local.repo_config.settings.auto_init

  topics = local.repo_config.topics
}
