# DartPad Live Preview Setup

This guide shows you how to embed live Flutter previews on your documentation pages using GitHub Gists.

## Quick Setup (5 minutes)

### Step 1: Create a GitHub Gist

1. Go to **https://gist.github.com** (sign in if needed)
2. Create a new gist:
   - **Filename**: `main.dart` ⚠️ **Must be exactly this name**
   - **Description**: "Alert Dialog - Flutterbits Demo"
   - **Content**: Copy the code from `flutter_components/dartpad_alert_dialog_shadcn_styled.dart` ✅ **Recommended**
3. Select **"Create public gist"** (not secret)
4. After creation, copy the Gist ID from the URL

### Step 2: Get Gist ID

After creating, you'll see a URL like:

```
https://gist.github.com/yourusername/5c0e154dd50af4a9ac856908061291bc
```

Copy just the ID part (the long hash at the end):
```
5c0e154dd50af4a9ac856908061291bc
```

### Step 2.5: Test in DartPad (Optional)

Verify it works by visiting:
```
https://dartpad.dev/?id=5c0e154dd50af4a9ac856908061291bc
```

Click "Run" - you should see the "Show Dialog" button!

### Step 3: Update Flutter Preview Component

Edit: `apps/v4/components/flutter-preview.tsx`

Find line 24 and replace `PASTE_YOUR_GIST_ID_HERE` with your Gist ID:

```typescript
const dartpadIds: Record<string, string> = {
  "alert-dialog": "e7076b40fb17a0fa899f9f7a154a0ea2", // ← Your ID here
}
```

### Step 4: View Live Preview

1. Save the file
2. Visit: http://localhost:4000/docs/flutter-components/alert-dialog
3. The live preview should now be embedded! 🎉

---

## How It Works

The `<FlutterPreview>` component in the MDX file:

```jsx
<FlutterPreview
  componentName="alert-dialog"
  title="An alert dialog with cancel and continue buttons."
  description="Try clicking the 'Show Dialog' button to see the alert in action."
  height={600}
/>
```

Maps to the DartPad ID in `flutter-preview.tsx`, which then embeds an iframe:

```html
<iframe src="https://dartpad.dev/embed-flutter.html?id=YOUR_ID&theme=dark&run=true" />
```

---

## Adding More Components

To add live previews for other components:

1. Create the DartPad code file: `flutter_components/dartpad_[component]_demo.dart`
2. Upload to DartPad and get the share ID
3. Add to the mapping in `flutter-preview.tsx`:

```typescript
const dartpadIds: Record<string, string> = {
  "alert-dialog": "abc123",
  "button": "def456",        // ← Add new component
  "input": "ghi789",         // ← Add new component
}
```

4. Use in MDX files:

```jsx
<FlutterPreview componentName="button" />
```

---

## Troubleshooting

### Preview shows "Live Preview Coming Soon"
- **Cause**: DartPad ID not set or invalid
- **Fix**: Double-check the ID in `flutter-preview.tsx`

### Preview shows blank screen
- **Cause**: DartPad code has errors
- **Fix**: Test in DartPad first, fix any errors, save again

### Preview loads but doesn't run
- **Cause**: Code doesn't auto-run
- **Fix**: Add `&run=true` to the iframe URL (already included in component)

### Can't click "Share" in DartPad
- **Cause**: Not logged in to GitHub
- **Fix**: Log in to DartPad with GitHub account

---

## Example: Complete Alert Dialog Setup

**File: `flutter_components/dartpad_alert_dialog_shadcn_styled.dart`**
```dart
// [Full code already created in this file]
```

**Share URL**: `https://dartpad.dev/?id=e7076b40fb17a0fa899f9f7a154a0ea2`

**flutter-preview.tsx**:
```typescript
"alert-dialog": "e7076b40fb17a0fa899f9f7a154a0ea2"
```

**Result**: Live, interactive Flutter preview embedded in your docs! ✨

---

## Advanced: Custom Embed Options

You can customize the iframe URL parameters:

```typescript
`https://dartpad.dev/embed-flutter.html?id=${dartpadId}&theme=dark&run=true&split=60`
```

Parameters:
- `theme=dark` or `theme=light` - UI theme
- `run=true` - Auto-run on load
- `split=60` - Code/preview split percentage (0-100)
- `null_safety=true` - Enable null safety (default)

---

**Need Help?** Check the main README or open an issue.
