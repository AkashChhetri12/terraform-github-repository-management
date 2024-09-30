locals {
  repo_config = yamldecode(file("${path.module}/data/repos/repo_config.yaml"))
}
