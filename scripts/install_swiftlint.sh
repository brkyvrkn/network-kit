#!/bin/sh

curl -L 'https://github.com/realm/SwiftLint/releases/download/0.39.2/portable_swiftlint.zip' -o swiftlint.zip
mkdir swiftlint_package
unzip swiftlint.zip -d swiftlint_package
rm -f swiftlint.zip