output "repository_url" {
  description = "URL of the created GitHub repository"
  value       = github_repository.repo.html_url
}
