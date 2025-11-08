# Flutter Web Build Approach (Like React!)

## The Problem

React previews: `<ComponentPreview />` - Done. ✅
Flutter previews: Gists, Zapp, external services... 😫

## The Solution: Build to Web

**Build Flutter components to web** and host them like you host your React app.

---

## 🚀 Setup (One Time)

### Step 1: Create Flutter Web Project

```bash
cd flutter_components
flutter create preview_app
cd preview_app
```

### Step 2: Add Components

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import '../examples/alert_dialog_zapp.dart' as alert_dialog;

void main() {
  // Read component from URL parameter
  final component = Uri.base.queryParameters['component'] ?? 'alert-dialog';
  final theme = Uri.base.queryParameters['theme'] ?? 'system';

  runApp(PreviewApp(component: component, theme: theme));
}

class PreviewApp extends StatelessWidget {
  final String component;
  final String theme;

  const PreviewApp({
    required this.component,
    required this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget app;

    switch (component) {
      case 'alert-dialog':
        app = alert_dialog.MyApp();
        break;
      default:
        app = const ErrorApp();
    }

    return app;
  }
}
```

### Step 3: Build for Web

```bash
flutter build web --release
```

This creates: `build/web/` directory

### Step 4: Host with Your Docs

Copy to your Next.js public folder:

```bash
cp -r build/web/ ../apps/v4/public/flutter-previews/
```

---

## 📦 Component Configuration

Update `flutter-preview.tsx`:

```typescript
const flutterPreviews: Record<string, string> = {
  "alert-dialog": "/flutter-previews/index.html?component=alert-dialog",
}

const previewUrl = flutterPreviews[componentName]
const fullUrl = previewUrl
  ? `${previewUrl}&theme=${currentTheme}`
  : undefined

// Embed local iframe
<iframe src={fullUrl} />
```

---

## ✅ Benefits

### Like React Previews

✅ **Self-hosted** - No external dependencies
✅ **Fast** - Served from your own CDN
✅ **Private** - No public gists needed
✅ **Version controlled** - Lives in your repo
✅ **Offline** - Works without internet
✅ **Theme switching** - URL parameter

### Workflow

```
React:
1. Write component → Done ✅

Flutter (this approach):
1. Write component
2. Build to web (once per update)
3. Done ✅
```

---

## 🔄 Update Workflow

```bash
# 1. Edit component
vim flutter_components/examples/alert_dialog_zapp.dart

# 2. Rebuild (2-3 seconds)
cd flutter_components/preview_app
flutter build web --release

# 3. Copy to public
cp -r build/web/* ../../apps/v4/public/flutter-previews/

# Done! Refresh docs page.
```

---

## 🎨 Directory Structure

```
apps/v4/
├── public/
│   └── flutter-previews/           ← Built Flutter web apps
│       ├── index.html
│       ├── flutter.js
│       └── ...
├── components/
│   └── flutter-preview.tsx         ← Loads local files
└── content/
    └── docs/flutter-components/
        └── alert-dialog.mdx         ← Uses <FlutterPreview />

flutter_components/
├── preview_app/                     ← Flutter web builder
│   └── lib/main.dart               ← Routes to components
└── examples/
    └── alert_dialog_zapp.dart      ← Your components
```

---

## 🚀 Advanced: Auto-Build

Add to `package.json`:

```json
{
  "scripts": {
    "build:flutter": "cd flutter_components/preview_app && flutter build web --release && cp -r build/web/* ../../apps/v4/public/flutter-previews/"
  }
}
```

Now just run:
```bash
npm run build:flutter
```

---

## 🎯 Comparison

| Approach | Setup | Updates | Dependencies |
|----------|-------|---------|-------------|
| **React** | None | Edit file | None |
| **Zapp.run** | Create project | Edit in Zapp | External service |
| **Build to Web** | One-time build setup | Rebuild + copy | None (self-hosted) |

**Build to Web is closest to React!**

---

## 💡 Even Better: CI/CD

Add to GitHub Actions:

```yaml
# .github/workflows/build-flutter-previews.yml
name: Build Flutter Previews

on:
  push:
    paths:
      - 'flutter_components/**'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: |
          cd flutter_components/preview_app
          flutter build web --release
          cp -r build/web/* ../../apps/v4/public/flutter-previews/
      - uses: stefanzweifel/git-auto-commit-action@v4
        with:
          commit_message: "Update Flutter previews"
```

Now it's **automatic**:
1. Edit Flutter component
2. Push to GitHub
3. CI builds and deploys
4. **Done!** (Just like React!)

---

## 🎉 Result

```jsx
// React
<ComponentPreview name="alert-dialog" />

// Flutter (with this approach)
<FlutterPreview componentName="alert-dialog" />
```

Both are:
- ✅ Self-hosted
- ✅ Fast
- ✅ No external deps
- ✅ Version controlled

**This is the React-equivalent approach!** 🚀
