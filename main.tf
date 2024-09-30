# Repository 
resource "github_repository" "this" {
  name        = var.repo_name
  description = var.repo_description
  visibility  = var.repo_visibility
  has_issues        = var.repo_features.has_issues
  has_projects      = var.repo_features.has_projects
  has_wiki          = var.repo_features.has_wiki
  has_downloads     = var.repo_features.has_downloads
  has_discussions   = var.repo_features.has_discussions
  allow_merge_commit = var.repo_settings.allow_merge_commit
  allow_squash_merge = var.repo_settings.allow_squash_merge
  allow_rebase_merge = var.repo_settings.allow_rebase_merge
  allow_auto_merge   = var.repo_settings.allow_auto_merge
  delete_branch_on_merge = var.repo_settings.delete_branch_on_merge
  auto_init              = true

  dynamic "template" {
    for_each = var.template_repo != null ? [1] : []
    content {
      owner      = var.template_repo.owner
      repository = var.template_repo.name
    }
  }
  
  topics = toset(var.is_terraform_module ? concat(["terraform"], var.topics) : var.topics)
}


resource "github_branch_protection" "main" {
  repository_id = github_repository.repo.node_id
  pattern       = "main"

  required_status_checks {
    strict   = true
    contexts = var.required_status_checks
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 1
  }

  enforce_admins = true
}
