#!/bin/bash
set -e


if ! command -v flutter &> /dev/null; then
  echo "Installing Flutter..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 $HOME/flutter
  export PATH="$PATH:$HOME/flutter/bin"
else
  echo "Flutter is already installed."
fi

flutter --version

flutter config --enable-web

flutter pub get

flutter build web --release