# Zapp.run vs DartPad: Complete Comparison

## 🎯 Why Zapp.run is Better

### Feature Comparison

| Feature | DartPad | Zapp.run | Winner |
|---------|---------|----------|---------|
| **File Support** | ❌ Single file only (main.dart) | ✅ Multiple files with file explorer | 🏆 Zapp |
| **Package Support** | ⚠️ Limited packages | ✅ ALL pub.dev packages | 🏆 Zapp |
| **Theme Switching** | ❌ Need 2 separate gists | ✅ URL parameter `?theme=dark/light` | 🏆 Zapp |
| **Code Visibility** | ⚠️ Split parameter buggy | ✅ `?split=0` (perfect) | 🏆 Zapp |
| **Lazy Loading** | ❌ No support | ✅ `?lazy=true` | 🏆 Zapp |
| **Source Options** | ⚠️ GitHub Gist only | ✅ Gist, GitHub, Zapp projects, pub.dev | 🏆 Zapp |
| **IDE Features** | ⚠️ Basic | ✅ Full IntelliSense, debugging, hot reload | 🏆 Zapp |
| **Sharing** | ⚠️ Removed from UI | ✅ Built-in share functionality | 🏆 Zapp |
| **Maintenance** | ⚠️ Stale (sharing removed) | ✅ Actively developed | 🏆 Zapp |
| **Performance** | ⚠️ Slow compilation | ✅ Faster | 🏆 Zapp |
| **Custom Integrations** | ❌ No API | ✅ JavaScript SDK available | 🏆 Zapp |

**Winner: Zapp.run 🏆 (11-0)**

---

## 📊 Implementation Comparison

### Old Approach (DartPad)

```typescript
// ❌ Problems:
// 1. Need TWO gists (light + dark)
// 2. Manual theme switching
// 3. Complex configuration

const dartpadIds = {
  "alert-dialog": {
    light: "gist-id-1", // Separate gist
    dark: "gist-id-2",  // Another gist
  },
}

// URL: https://dartpad.dev/embed-flutter.html?id=GIST_ID&theme=dark&run=true&split=0
```

**Issues:**
- 😫 Create 2 gists per component
- 😫 Update both when code changes
- 😫 More maintenance overhead
- 😫 Iframe reloads on theme change (janky)

### New Approach (Zapp.run)

```typescript
// ✅ Benefits:
// 1. ONE gist with both themes
// 2. Automatic theme switching
// 3. Clean, simple configuration

const zappProjects = {
  "alert-dialog": {
    type: "gist",
    id: "8489153adfb7e284880f463cafc05c9e", // ONE gist!
  },
}

// URL: https://zapp.run/gist/GIST_ID?split=0&theme=dark&lazy=true
```

**Benefits:**
- ✅ One gist per component
- ✅ Theme switches via URL param
- ✅ Less maintenance
- ✅ Smoother transitions

---

## 🚀 URL Parameters

### DartPad Parameters

```
https://dartpad.dev/embed-flutter.html?
  id=GIST_ID          # Gist ID
  &theme=dark         # Theme
  &run=true           # Auto-run
  &split=0            # Hide code (buggy)
```

### Zapp.run Parameters

```
https://zapp.run/gist/GIST_ID?
  split=0             # Hide code (0-100, 0 = preview only)
  &theme=dark         # Theme (dark/light/system)
  &lazy=true          # Lazy load for performance
```

Additional Zapp params:
- `&readonly=true` - Make editor read-only
- `&autofocus=true` - Auto-focus editor
- `&mode=flutter` - Specify mode

---

## 📁 Source Options

### DartPad
```
✅ GitHub Gist only
❌ No other options
```

### Zapp.run
```typescript
// Option 1: Gist
{ type: "gist", id: "abc123..." }
// URL: https://zapp.run/gist/abc123

// Option 2: GitHub repo
{ type: "github", path: "user/repo/path/to/main.dart" }
// URL: https://zapp.run/github/user/repo/path/to/main.dart

// Option 3: Zapp project
{ type: "zapp", id: "project-id" }
// URL: https://zapp.run/edit/project-id

// Option 4: pub.dev package example
// URL: https://zapp.run/pub/package_name/version
```

---

## 🎨 Theme Switching Comparison

### DartPad Approach
```typescript
// ❌ Need 2 separate gists with forced themes
// dartpad_alert_dialog_light.dart:
themeMode: ThemeMode.light, // FORCED

// dartpad_alert_dialog_dark.dart:
themeMode: ThemeMode.dark,  // FORCED

// Switch gist based on theme
const gistId = theme === 'light' ? lightGistId : darkGistId
```

### Zapp.run Approach
```typescript
// ✅ ONE gist with dynamic theme
// dartpad_alert_dialog.dart:
themeMode: ThemeMode.system, // Controlled by Zapp URL param

// Just change URL parameter
const url = `https://zapp.run/gist/${gistId}?theme=${theme}`
```

**Result:** Zapp.run is **WAY smoother** - no gist switching, just URL param change!

---

## 💾 Migration Steps

### Step 1: Update Your Gist

Edit your existing gist (8489153adfb7e284880f463cafc05c9e):

```dart
// Keep ThemeMode.system - Zapp controls it via URL
themeMode: ThemeMode.system,
```

### Step 2: Configuration is Already Updated!

The `flutter-preview.tsx` now uses:

```typescript
const zappProjects = {
  "alert-dialog": {
    type: "gist",
    id: "8489153adfb7e284880f463cafc05c9e",
  },
}
```

### Step 3: Test It!

1. **Refresh your page**: `http://localhost:4000/docs/flutter-components/alert-dialog`
2. **Toggle theme** - Watch it switch smoothly! 🎨
3. **Click "Open in Zapp"** - See full IDE with your code

---

## 🎯 What You Get

### Before (DartPad)
```
❌ Two gists to maintain
❌ Manual gist switching
❌ Limited packages
❌ Single file only
❌ Janky theme transitions
```

### After (Zapp.run)
```
✅ One gist to maintain
✅ Automatic theme switching
✅ ALL pub.dev packages
✅ Multiple file support
✅ Smooth theme transitions
✅ Better IDE experience
✅ Faster performance
✅ Actively maintained
```

---

## 📚 Zapp.run Documentation

- **Main Site**: https://zapp.run
- **Docs**: https://docs.zapp.run
- **Embedding Guide**: https://docs.zapp.run/features/share-and-embed
- **Blog Announcement**: https://invertase.io/blog/announcing-zapp-rapid-flutter-dart-development-environment-in-browser

---

## 🎉 Summary

**Zapp.run is the clear winner!**

- ✅ Better in every way
- ✅ Easier to maintain
- ✅ Smoother user experience
- ✅ More features
- ✅ Actively developed
- ✅ Future-proof

**Your implementation is now using Zapp.run!** Just refresh and toggle the theme to see the magic happen. 🚀
