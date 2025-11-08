# Flutterbits Flutter Preview - Quick Start

## 🎉 What You Now Have

A **React-like** Flutter preview system - no gists, no external services!

```jsx
// It's this simple:
<FlutterPreview componentName="alert-dialog" />

// Just like React:
<ComponentPreview name="alert-dialog" />
```

---

## ⚡ 3-Step Setup

### Step 1: Install Flutter (if needed)

```bash
flutter --version
```

If not installed: https://docs.flutter.dev/get-started/install

### Step 2: Build Preview

```bash
cd flutter_components/preview_app
./build.sh
```

### Step 3: Start Dev Server

```bash
cd ../..
npm run dev
```

**Done!** Visit: http://localhost:4000/docs/flutter-components/alert-dialog

---

## 🎨 How It Works

```
┌─────────────────────────────────────────────────────────┐
│ 1. Edit Component                                       │
│    flutter_components/preview_app/lib/main.dart         │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│ 2. Build to Web                                         │
│    ./build.sh                                           │
│    → Compiles Flutter to JavaScript                     │
│    → Outputs to build/web/                              │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│ 3. Copy to Next.js                                      │
│    cp build/web/* apps/v4/public/flutter-previews/      │
│    → Now accessible at /flutter-previews/               │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│ 4. Embed in Docs                                        │
│    <FlutterPreview componentName="alert-dialog" />      │
│    → Loads: /flutter-previews/index.html?component=...  │
│    → Theme switches automatically!                      │
└─────────────────────────────────────────────────────────┘
```

---

## 🆚 Comparison

### Before (External Services)

```
❌ Create Gist/Zapp project
❌ Manage external accounts
❌ Depend on external services
❌ Public code exposure
❌ Network latency
```

### After (Build to Web)

```
✅ Self-hosted in your repo
✅ No external dependencies
✅ Private code
✅ Fast local serving
✅ Version controlled
✅ Same workflow as React!
```

---

## 🔄 Update Workflow

When you modify a component:

```bash
# 1. Edit the component code
vim flutter_components/preview_app/lib/main.dart

# 2. Rebuild (2-3 seconds)
cd flutter_components/preview_app && ./build.sh

# 3. Refresh browser
# Done!
```

**Tip**: Keep the build script running in a terminal window for quick iterations.

---

## 📁 File Structure

```
flutter_components/
├── preview_app/
│   ├── lib/main.dart           ← Your components live here
│   ├── build.sh                ← Run this to build
│   └── README.md               ← Detailed guide
├── lib/components/ui/
│   └── alert_dialog.dart       ← Reusable component library
└── examples/
    └── alert_dialog_demo.dart  ← Standalone examples

apps/v4/
├── components/
│   └── flutter-preview.tsx     ← Preview component (configured!)
├── content/docs/
│   └── flutter-components/
│       └── alert-dialog.mdx    ← Uses <FlutterPreview />
└── public/
    └── flutter-previews/       ← Built files go here
        ├── index.html          ← Entry point
        └── flutter.js          ← Flutter engine
```

---

## 💡 Pro Tips

### 1. Auto-Rebuild on Change

Add to `package.json`:

```json
{
  "scripts": {
    "build:flutter": "cd flutter_components/preview_app && ./build.sh",
    "watch:flutter": "cd flutter_components/preview_app && flutter run -d web-server --web-port=8080"
  }
}
```

### 2. Add More Components

Edit `flutter_components/preview_app/lib/main.dart`:

```dart
switch (component) {
  case 'alert-dialog':
    componentWidget = const AlertDialogDemo();
    break;
  case 'button':  // ← Add new component
    componentWidget = const ButtonDemo();
    break;
}
```

Then in `flutter-preview.tsx`:

```typescript
const flutterComponents = {
  "alert-dialog": "alert-dialog",
  "button": "button",  // ← Register it
}
```

### 3. Test Locally

Direct URL access:
```
http://localhost:4000/flutter-previews/index.html?component=alert-dialog&theme=dark
```

---

## 🎯 What You Get

| Feature | Status |
|---------|--------|
| Self-hosted | ✅ |
| Fast loading | ✅ |
| Theme switching | ✅ |
| Offline support | ✅ |
| Version control | ✅ |
| No external deps | ✅ |
| Like React | ✅ |

---

## 🆘 Need Help?

- **Detailed setup**: See `flutter_components/preview_app/README.md`
- **Full guide**: See `flutter_components/BUILD_TO_WEB.md`
- **Troubleshooting**: Check the preview_app README
- **Comparison**: See `flutter_components/ZAPP_VS_DARTPAD.md`

---

## 🎉 You're All Set!

Your Flutter previews now work **exactly like React** - self-hosted, fast, and simple.

**Next Steps:**
1. Run `./build.sh` to build the preview
2. Start your dev server
3. Visit the docs page
4. Toggle theme and watch it work! 🚀

No gists, no Zapp, no external services. Just pure, simple, local previews. **Exactly like React!** ✨
