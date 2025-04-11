#!/bin/bash
set -e

function main {
  install_git_hooks
}

function install_git_hooks {
  echo "Installing git hooks..."
  git config core.hooksPath scripts/hooks
}

main
