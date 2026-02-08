# Image conversion scripts

This folder contains a small shell script to convert HEIC/HEIF images to JPEG for web use.

Files
- `convert_heic.sh` — converts `.HEIC`/`.heic` files in `gallery/newimg` to JPEG files and writes them to `gallery/newimg_converted`.

Usage
1. Make the script executable (one-time):

```bash
chmod +x scripts/convert_heic.sh
```

2. Run the script:

```bash
./scripts/convert_heic.sh
```

Notes
- On macOS the script uses the built-in `sips` utility. On other systems it will try to use ImageMagick (`magick`).
- If neither is available, install ImageMagick (for macOS: `brew install imagemagick`) or run the script on macOS.
- Converted files are placed in `gallery/newimg_converted`. The original files are not modified.

If you want the converted images moved back into `gallery/newimg` or referenced automatically in `gallery/index.html`, tell me and I can add an optional flag to the script to overwrite originals and optionally update the HTML.
