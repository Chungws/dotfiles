#!/bin/bash

set -ex

# Install Window Management Tool
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

mkdir -p ~/.config/yabai
mkdir -p ~/.config/skhd

cp yabairc ~/.config/yabai/yabairc
cp skhdrc ~/.config/skhd/skhdrc

yabai --start-service
skhd --start-service
