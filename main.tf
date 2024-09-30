resource "github_repository" "repo" {
  name        = local.repo_config.repo_name
  description = local.repo_config.repo_description
  visibility  = local.repo_config.repo_visibility

  has_issues        = local.repo_config.repo_features.has_issues
  has_projects      = local.repo_config.repo_features.has_projects
  has_wiki          = local.repo_config.repo_features.has_wiki
  has_downloads     = local.repo_config.repo_features.has_downloads
  has_discussions   = local.repo_config.repo_features.has_discussions

  allow_merge_commit = local.repo_config.repo_settings.allow_merge_commit
  allow_squash_merge = local.repo_config.repo_settings.allow_squash_merge
  allow_rebase_merge = local.repo_config.repo_settings.allow_rebase_merge
  allow_auto_merge   = local.repo_config.repo_settings.allow_auto_merge

  delete_branch_on_merge = local.repo_config.repo_settings.delete_branch_on_merge
  auto_init              = true

  dynamic "template" {
    for_each = local.repo_config.template_repo != null ? [1] : []
    content {
      owner      = local.repo_config.template_repo.owner
      repository = local.repo_config.template_repo.name
    }
  }
}

resource "github_branch_protection" "main" {
  repository_id = github_repository.repo.node_id
  pattern       = "main"

  required_status_checks {
    strict   = true
    contexts = local.repo_config.required_status_checks
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 1
  }

  enforce_admins = true
}
