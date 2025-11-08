#!/bin/bash

# Flutterbits Preview Builder
# Builds Flutter components to web and copies to Next.js public folder

set -e  # Exit on error

echo "🚀 Building Flutterbits Flutter Previews..."
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed!"
    echo ""
    echo "Please install Flutter:"
    echo "  macOS: brew install --cask flutter"
    echo "  Other: https://docs.flutter.dev/get-started/install"
    exit 1
fi

# Check Flutter version
echo "📦 Flutter version:"
flutter --version | head -1
echo ""

# Get dependencies
echo "📥 Getting dependencies..."
flutter pub get
echo ""

# Build for web
echo "🔨 Building for web (release mode)..."
flutter build web --release --no-wasm-dry-run
echo ""

# Copy to Next.js public folder
OUTPUT_DIR="../../apps/v4/public/flutter-previews"
echo "📋 Copying to Next.js public folder..."
echo "   Target: $OUTPUT_DIR"

# Create directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Copy build files
cp -r build/web/* "$OUTPUT_DIR/"

echo ""
echo "✅ Build complete!"
echo ""
echo "Preview URLs:"
echo "  Light: http://localhost:4000/flutter-previews/index.html?component=alert-dialog&theme=light"
echo "  Dark:  http://localhost:4000/flutter-previews/index.html?component=alert-dialog&theme=dark"
echo ""
echo "Docs page:"
echo "  http://localhost:4000/docs/flutter-components/alert-dialog"
echo ""
echo "Next steps:"
echo "  1. Make sure dev server is running: npm run dev"
echo "  2. Visit the docs page above"
echo "  3. Toggle theme to see it switch!"
echo ""
