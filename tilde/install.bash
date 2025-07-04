#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
shopt -s failglob inherit_errexit

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

dotfiles=(
  .config/nvim
  .config/fish
  .config/i3
  .config/polybar
  .config/fehbg
  .config/hypr
)

for dotfile in "${dotfiles[@]}"; do
  ln --force --symbolic --verbose "${script_dir}/${dotfile}" "$HOME"/.config
done
