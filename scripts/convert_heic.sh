#!/usr/bin/env bash
set -euo pipefail

# Converts HEIC/HEIF images in gallery/newimg to JPEG files.
# - On macOS this uses `sips` (built-in).
# - If ImageMagick (`magick`) is available it will be used instead.
# Output directory: `gallery/newimg_converted` (created if missing).

SRC_DIR="$(dirname "$(dirname "$0")")/gallery/newimg"
OUT_DIR="$SRC_DIR"_converted

echo "Source: $SRC_DIR"
echo "Output: $OUT_DIR"

mkdir -p "$OUT_DIR"

shopt -s nullglob 2>/dev/null || true

converted=0

for src in "$SRC_DIR"/*.{HEIC,heic,HEIF,heif}; do
  [ -f "$src" ] || continue
  filename="$(basename "$src")"
  name="${filename%.*}"
  out="$OUT_DIR/${name}.jpg"

  if command -v sips >/dev/null 2>&1; then
    # macOS native conversion
    sips -s format jpeg "$src" --out "$out" >/dev/null
  elif command -v magick >/dev/null 2>&1; then
    # ImageMagick conversion
    magick "$src" -quality 90 "$out"
  else
    echo "Error: neither 'sips' (macOS) nor 'magick' (ImageMagick) found in PATH." >&2
    echo "Install ImageMagick (brew install imagemagick) or run on macOS." >&2
    exit 1
  fi

  printf "Converted: %s -> %s\n" "$src" "$out"
  converted=$((converted+1))
done

echo "Done. Converted $converted file(s). Output in: $OUT_DIR"

exit 0
