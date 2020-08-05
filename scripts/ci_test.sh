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

set -o pipefail

xcodebuild build-for-testing -enableCodeCoverage YES -project "$project" -scheme "$scheme" -sdk $simulator -destination "${destinations[0]}" ONLY_ACTIVE_ARCH=YES | xcpretty;

for destination in "${destinations[@]}"; do
    xcodebuild test-without-building -enableCodeCoverage YES -project "$project" -scheme "$scheme" -sdk $simulator -destination "$destination" ONLY_ACTIVE_ARCH=YES | xcpretty;
done