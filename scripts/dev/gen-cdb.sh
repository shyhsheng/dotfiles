#!/usr/bin/env bash
set -euo pipefail

OUTPUT="compile_commands.json"

rm -f "$OUTPUT"

if ! command -v bear >/dev/null 2>&1; then
    echo "ERROR: bear not found"
    echo "Install it first:"
    echo "  sudo apt install bear"
    exit 1
fi

echo "Generating $OUTPUT in:"
pwd

BUILD_CMD=(make V=1 -j"$(nproc)" "$@")

if bear --help 2>&1 | grep -q -- '--output'; then
    bear --output "$OUTPUT" -- "${BUILD_CMD[@]}"
else
    bear "${BUILD_CMD[@]}"
fi

if [ -f "$OUTPUT" ]; then
    echo "Generated: $OUTPUT"
else
    echo "ERROR: failed to generate $OUTPUT"
    exit 1
fi
