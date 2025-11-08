# Flutter Component Preview Builder

This app builds Flutter components to web and serves them locally with your Next.js docs site.

## 🎯 The React-Like Approach

```jsx
// React (shadcn/ui)
<ComponentPreview name="alert-dialog" />

// Flutter (Flutterbits) - Same simplicity!
<FlutterPreview componentName="alert-dialog" />
```

Both load from **local files**, no external services! ✅

---

## 🚀 Quick Start

### Prerequisites

1. **Flutter SDK** installed
   ```bash
   flutter --version
   ```
   If not installed: https://docs.flutter.dev/get-started/install

### Build Preview

```bash
cd flutter_components/preview_app
./build.sh
```

That's it! The script will:
1. Get dependencies
2. Build to web (release mode)
3. Copy to `apps/v4/public/flutter-previews/`

### View Preview

1. Start Next.js dev server:
   ```bash
   cd ../..
   npm run dev
   ```

2. Visit: http://localhost:4000/docs/flutter-components/alert-dialog

3. **Toggle theme** - watch it switch! 🎨

---

## 📁 How It Works

### File Structure

```
flutter_components/
└── preview_app/
    ├── lib/
    │   └── main.dart          ← Routes components via URL params
    ├── web/
    │   ├── index.html
    │   └── manifest.json
    ├── pubspec.yaml
    ├── build.sh               ← Build script
    └── README.md              ← You are here

apps/v4/
└── public/
    └── flutter-previews/      ← Built files go here
        ├── index.html
        ├── flutter.js
        └── ...
```

### URL Structure

```
/flutter-previews/index.html?component=alert-dialog&theme=light
                             ↑                       ↑
                             |                       └─ Theme
                             └─ Component name
```

The `main.dart` router reads these URL parameters and loads the right component with the right theme.

---

## 🔄 Adding New Components

### Step 1: Add Component to main.dart

Edit `lib/main.dart`:

```dart
// In the switch statement, add your component:
switch (component) {
  case 'alert-dialog':
    componentWidget = const AlertDialogDemo();
    break;
  case 'button':  // ← New component
    componentWidget = const ButtonDemo();
    break;
  // ...
}
```

### Step 2: Rebuild

```bash
./build.sh
```

### Step 3: Configure in Next.js

Edit `apps/v4/components/flutter-preview.tsx`:

```typescript
const flutterComponents: Record<string, string> = {
  "alert-dialog": "alert-dialog",
  "button": "button",  // ← Add your component
}
```

### Step 4: Use in Docs

```jsx
<FlutterPreview componentName="button" />
```

Done! ✅

---

## 🎨 Theme Switching

The preview automatically follows your site's theme:

```typescript
// In flutter-preview.tsx:
const currentTheme = useTheme()
const previewUrl = `/flutter-previews/index.html?theme=${currentTheme}`
```

When user toggles theme:
1. URL parameter updates (`?theme=dark` → `?theme=light`)
2. Iframe reloads with new theme
3. Flutter app reads parameter and applies theme

**No separate builds needed!** One build supports both themes.

---

##  Performance

### Build Size

```
flutter build web --release --web-renderer canvaskit
```

- **Initial build**: ~20-30 seconds
- **Output size**: ~2-3 MB (gzipped)
- **Load time**: < 1 second on localhost
- **Theme switch**: Instant (iframe reload)

### Optimization Tips

1. **Canvaskit renderer**: Better performance, consistent rendering
2. **Release mode**: Optimized bundle
3. **Local serving**: Fast, no network latency
4. **Lazy iframe**: Only loads when scrolled into view

---

## 🆚 vs External Services

| Feature | Build to Web | Zapp.run | DartPad |
|---------|--------------|----------|---------|
| **Setup** | One-time build | Create project | Create gist |
| **Hosting** | Self-hosted ✅ | External | External |
| **Speed** | Fast ⚡ | Medium | Slow |
| **Offline** | Yes ✅ | No | No |
| **Privacy** | Private ✅ | Public | Public |
| **Cost** | Free ✅ | Free | Free |
| **Like React?** | **YES** ✅ | No | No |

---

## 🛠️ Troubleshooting

### "flutter: command not found"

Install Flutter SDK: https://docs.flutter.dev/get-started/install

### "Build failed"

1. Ensure Flutter is up to date:
   ```bash
   flutter upgrade
   ```

2. Clean and rebuild:
   ```bash
   flutter clean
   flutter pub get
   ./build.sh
   ```

### "Preview shows blank page"

1. Check browser console for errors
2. Verify files exist in `apps/v4/public/flutter-previews/`
3. Try accessing directly: http://localhost:4000/flutter-previews/index.html?component=alert-dialog

### "Theme doesn't switch"

1. Check `themeMode: ThemeMode.system` in component code
2. Verify URL parameter updates when toggling theme
3. Check browser console for iframe reload

---

## 📦 Build Script Details

The `build.sh` script:

```bash
#!/bin/bash
# 1. Checks Flutter installation
# 2. Gets dependencies (flutter pub get)
# 3. Builds to web (flutter build web --release)
# 4. Copies to Next.js public folder
```

You can also run these commands manually:

```bash
flutter pub get
flutter build web --release --web-renderer canvaskit
cp -r build/web/* ../../apps/v4/public/flutter-previews/
```

---

## 🎯 Summary

This approach gives you:

✅ **Self-hosted** - No external dependencies
✅ **Fast** - Local files, instant loading
✅ **Private** - Code stays in your repo
✅ **Simple** - Same workflow as React components
✅ **Automatic theme** - One build, both themes
✅ **Version controlled** - Git tracks everything

**Just like React!** 🚀

---

## 📚 Resources

- [Flutter Web Docs](https://docs.flutter.dev/platform-integration/web)
- [BUILD_TO_WEB.md](../BUILD_TO_WEB.md) - Full guide
- [ZAPP_VS_DARTPAD.md](../ZAPP_VS_DARTPAD.md) - Comparison

---

**Questions?** Check the main [flutter_components/README.md](../README.md)
