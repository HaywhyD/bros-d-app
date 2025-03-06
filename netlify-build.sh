#!/bin/bash
set -e

git clone https://github.com/flutter/flutter.git -b stable --depth 1 $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

flutter --version

flutter config --enable-web

flutter pub get

flutter build web --release