variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
}

variable "repo_name" {
  description = "Name of the repository"
  type        = string
}

variable "repo_description" {
  description = "Description of the repository"
  type        = string
  default     = ""
}

variable "repo_visibility" {
  description = "Visibility of the repository (public or private)"
  type        = string
  default     = "private"
}

variable "repo_features" {
  description = "Features to enable for the repository"
  type = object({
    has_issues      = bool
    has_projects    = bool
    has_wiki        = bool
    has_downloads   = bool
    has_discussions = bool
  })
  default = {
    has_issues      = true
    has_projects    = false
    has_wiki        = false
    has_downloads   = false
    has_discussions = false
  }
}

variable "repo_settings" {
  description = "Settings for the repository"
  type = object({
    allow_merge_commit       = bool
    allow_squash_merge       = bool
    allow_rebase_merge       = bool
    allow_auto_merge         = bool
    delete_branch_on_merge   = bool
  })
  default = {
    allow_merge_commit       = true
    allow_squash_merge       = true
    allow_rebase_merge       = true
    allow_auto_merge         = false
    delete_branch_on_merge   = true
  }
}

variable "template_repo" {
  description = "Template repository to use (if any)"
  type = object({
    owner = string
    name  = string
  })
  default = null
}

variable "required_status_checks" {
  description = "List of required status checks for the main branch"
  type        = list(string)
  default     = ["ci/travis"]
}
