#!/bin/bash

pkgs="epoch-bin epoch-nightly-bin lf-cli lf-cli-bin lf-cli-nightly-bin"

for pkg in $pkgs; do
  echo "push $pkg"
  git subtree push --prefix="$pkg" ssh://aur@aur.archlinux.org/"$pkg".git master
done
