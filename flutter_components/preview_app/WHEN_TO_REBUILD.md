# When to Rebuild Flutter Previews

## ✅ You NEED to rebuild when:

1. **Component code changes**
   - Modified `lib/main.dart`
   - Changed component styling/behavior
   - Fixed bugs

2. **Adding new components**
   - Added new component case in the switch statement
   - New component demo added

3. **First time setup**
   - Initial build after cloning repo

## ❌ You DON'T need to rebuild when:

1. **Documentation changes**
   - Editing MDX files
   - Updating code examples
   - Changing descriptions

2. **Theme toggle**
   - Theme switching is handled by URL parameters
   - No rebuild needed!

3. **Next.js code changes**
   - Editing `flutter-preview.tsx`
   - Updating docs pages
   - Changing styles

## 🔄 How to Rebuild

```bash
cd flutter_components/preview_app
./build.sh
```

Takes ~5-10 seconds total.

## 💡 Quick Tip

The preview iframe gets the theme from URL:
```
?theme=light  → Shows light theme
?theme=dark   → Shows dark theme
```

No rebuild needed for theme switching! The iframe just reloads with a different URL parameter. 🎉
