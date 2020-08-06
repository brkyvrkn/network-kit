#!/bin/sh

while getopts "s:d:k:p:" opt; do
    case $opt in
        s) scheme=${OPTARG};;
        d) destinations+=("$OPTARG");;
        k) simulator=${OPTARG};;
        p) project=${OPTARG};;
    esac
done
shift $((OPTIND -1))

for destination in "${destinations[@]}"; do
    set -o pipefail && xcodebuild test -enableCodeCoverage YES -project $project -scheme $scheme -sdk "$simulator" -destination "$destination" ONLY_ACTIVE_ARCH=YES
done