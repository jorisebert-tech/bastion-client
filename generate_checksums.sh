#!/usr/bin/env bash
set -euo pipefail

# Client checksum
CLIENT_DIR="./client"
CLIENT_FILE="$CLIENT_DIR/client.jar"
CLIENT_OUTPUT="$CLIENT_DIR/client_version.json"

CLIENT_HASH=$(sha256sum "$CLIENT_FILE" | awk '{print $1}')

cat > "$CLIENT_OUTPUT" <<EOF
{
  "file": "client.jar",
  "checksum": "$CLIENT_HASH"
}
EOF

echo "Client checksum saved to $CLIENT_OUTPUT"

# Runtimes checksums
RUNTIMES_DIR="./runtimes"
RUNTIMES_OUTPUT="$RUNTIMES_DIR/runtime_versions.json"

echo "[" > "$RUNTIMES_OUTPUT"

first=true
for file in "$RUNTIMES_DIR"/*; do
  if [ -f "$file" ]; then
    HASH=$(sha256sum "$file" | awk '{print $1}')
    NAME=$(basename "$file")

    if [ "$first" = false ]; then
      echo "," >> "$RUNTIMES_OUTPUT"
    fi
    first=false

    cat >> "$RUNTIMES_OUTPUT" <<EOF
  {
    "file": "$NAME",
    "checksum": "$HASH"
  }
EOF
  fi
done

echo "]" >> "$RUNTIMES_OUTPUT"

echo "Runtime checksums saved to $RUNTIMES_OUTPUT"
