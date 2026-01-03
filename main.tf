provider "github" {
  owner = var.github_owner
  token = var.github_token
}

resource "github_repository" "this" {
  name       = var.repository_name
  visibility = var.repository_visibility
  auto_init  = true
}

resource "github_branch" "default" {
  repository = github_repository.this.name
  branch     = var.default_branch
}

resource "github_branch_default" "default" {
  repository = github_repository.this.name
  branch     = github_branch.default.branch
}

resource "github_repository_deploy_key" "this" {
  title      = var.public_key_openssh_title
  repository = github_repository.this.name
  key        = var.public_key_openssh
  read_only  = false
}
