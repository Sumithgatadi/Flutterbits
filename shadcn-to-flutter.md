# shadcn to Flutter: Building a Copy-Paste Component Library

## Overview

This document explores how to bring the shadcn/ui philosophy to Flutter - a true copy-paste component library where developers own their code.

## Current State of Flutter Component Libraries

### Existing Projects:
1. **fluttercn** - Copy-paste approach but less maintained
2. **shadcn_ui (nank1ro)** - Pub package (not true copy-paste)
3. **shadcn_flutter** - Pub package dependency
4. **Forui** - Closest to the philosophy, minimalistic approach

### The Gap:
There's still room for a well-executed shadcn-style Flutter library that:
- Uses a true copy-paste CLI (not a pub package)
- Gives developers complete ownership of components
- Provides beautiful, modern defaults
- Offers excellent developer experience

---

## 1. Styling Approach

### The Challenge:
Flutter doesn't have an equivalent to Tailwind CSS, which shadcn/ui relies on heavily.

### Solution Options:

#### Option A: Theme-based Approach (Recommended)
**Best for:** Quick MVP, Flutter developer familiarity

```dart
// Define a theme once
final theme = AppTheme(
  primaryColor: Colors.blue,
  radius: 8.0,
  spacing: 16.0
);

// Components use it automatically
Button(text: "Click me") // Already styled
```

**Pros:**
- Simple and maintainable
- Familiar to Flutter developers
- Easy to implement
- Consistent across app

**Cons:**
- Less granular control than Tailwind
- Not as flexible for one-off customizations

#### Option B: Utility-style Classes
**Best for:** Closest shadcn/Tailwind experience

```dart
// Similar to Tailwind
Button(
  className: "bg-primary rounded-lg p-4"
)
```

**Pros:**
- Feels like shadcn/Tailwind
- Granular control
- Familiar for web developers

**Cons:**
- Need to build entire utility system from scratch
- Complex implementation
- Not idiomatic Flutter

#### Option C: Direct Styling
**Best for:** Maximum control

```dart
Button(
  backgroundColor: Colors.blue,
  borderRadius: 8,
  padding: 16
)
```

**Pros:**
- Maximum control per component
- No abstraction overhead
- Native Flutter approach

**Cons:**
- Verbose
- Harder to maintain consistency
- Repetitive code

### Recommendation:
**Start with Option A (Theme-based)** - it's the fastest path to MVP and most familiar to Flutter developers.

---

## 2. Base Primitives

### The Challenge:
shadcn/ui uses Radix UI for accessible, unstyled component primitives. Flutter needs an equivalent foundation.

### Solution Options:

#### Option A: Flutter's Built-in Widgets (Recommended)
**Use:** Container, GestureDetector, AnimatedContainer, Material widgets

**Pros:**
- ✅ No extra dependencies
- ✅ Well-documented and tested
- ✅ Developers already know them
- ✅ Maintained by Google
- ✅ Accessibility built-in
- ✅ Performance optimized

**Cons:**
- ❌ Some Material Design influence
- ❌ Less control over internal behavior

**Example:**
```dart
class ShadcnButton extends StatelessWidget {
  // Built on top of Flutter's GestureDetector, Container, etc.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(theme.spacing),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(theme.radius),
        ),
        child: child,
      ),
    );
  }
}
```

#### Option B: Custom Primitives from Scratch
**Build:** Your own low-level widget system

**Pros:**
- ✅ Complete control
- ✅ No Material Design influence
- ✅ Exact behavior you want

**Cons:**
- ❌ Months of development time
- ❌ Need to handle accessibility manually
- ❌ More bugs initially
- ❌ Maintenance burden
- ❌ Less battle-tested

### Recommendation:
**Use Option A (Flutter widgets)** - build beautiful styling on top of solid, proven foundations.

---

## 3. Developer Experience

### How It Works:

```bash
# 1. Initialize in project
$ flutter_shadcn init

# 2. Add components
$ flutter_shadcn add button
$ flutter_shadcn add card
$ flutter_shadcn add dialog

# 3. Code is copied to project
# lib/components/ui/button.dart
# lib/components/ui/card.dart
# lib/components/ui/dialog.dart

# 4. Developers own and can customize
```

### Usage in App:

```dart
import 'components/ui/button.dart';
import 'components/ui/card.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text("Welcome"),
          Button(
            onPressed: () {},
            child: Text("Click me"),
          ),
        ],
      ),
    );
  }
}
```

### Customization:

Since developers own the code, they can directly edit:
```dart
// lib/components/ui/button.dart
// Change colors, animations, behavior, etc.
```

---

## 4. MVP Scope

### Design System:
- Color palette (primary, secondary, accent, neutral, error, success)
- Typography scale (heading1-6, body, caption)
- Spacing system (xs, sm, md, lg, xl)
- Border radius values
- Elevation/shadow system

### Core Components (Start with 5-10):
1. **Button** - Primary, secondary, outline, ghost variants
2. **Input** - Text field with validation
3. **Card** - Container with elevation
4. **Alert** - Info, warning, error, success
5. **Dialog** - Modal dialogs
6. **Select** - Dropdown picker
7. **Checkbox** - Checkboxes and radio buttons
8. **Switch** - Toggle switch
9. **Badge** - Small status indicators
10. **Avatar** - User profile images

### CLI Tool:
- `init` - Initialize project with theme
- `add [component]` - Add specific component
- `list` - Show available components
- `update` - Update existing components (optional)

### Documentation Site:
- Component showcase with live examples
- Installation guide
- Customization guide
- Theming documentation
- Migration guide from Material

---

## 5. Recommended Tech Stack

| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Styling** | Theme-based (custom ThemeData) | Fastest, most familiar |
| **Primitives** | Flutter built-in widgets | Battle-tested, accessible |
| **CLI** | Dart CLI package | Native to Flutter ecosystem |
| **Docs** | Next.js/Docusaurus | Static site, easy hosting |
| **Examples** | Flutter web demos | Interactive previews |

---

## 6. Key Differentiators

### vs Existing Flutter Libraries:
1. **True ownership** - Copy-paste, not package dependency
2. **No lock-in** - Modify components freely
3. **Modern aesthetic** - Not Material Design
4. **Great DX** - Simple CLI, clear docs
5. **Accessibility first** - WCAG compliant from day one

### vs shadcn/ui (web):
1. **No Tailwind needed** - Theme-based approach
2. **Flutter-native** - Idiomatic Dart/Flutter code
3. **Cross-platform** - iOS, Android, web, desktop
4. **Performance** - Flutter's rendering engine

---

## 7. Success Metrics

### Developer Adoption:
- GitHub stars
- CLI downloads
- Components used in production apps

### Community Health:
- Contributions
- Issues/PRs
- Community components/variants

### Quality:
- Accessibility compliance
- Performance benchmarks
- Test coverage

---

## 8. Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Competing with established libs | Medium | Focus on true copy-paste DX |
| Maintenance burden | High | Start small, grow gradually |
| Flutter ecosystem changes | Medium | Use stable APIs, monitor changes |
| Theming complexity | Medium | Provide sensible defaults |

---

## 9. Next Steps

1. **Validate** - Survey Flutter developers on interest
2. **Design** - Create design system and component specs
3. **Prototype** - Build 2-3 core components
4. **CLI** - Develop basic CLI tool
5. **Test** - Get early feedback from developers
6. **Launch** - Release MVP with docs
7. **Iterate** - Add components based on demand

---

## Conclusion

Building a shadcn-style component library for Flutter is viable and valuable. The key is to:
- Start with theme-based styling (not reinventing Tailwind)
- Build on Flutter's solid widget foundation
- Focus on developer experience (simple CLI, great docs)
- Give developers true ownership of their components

The market validation is clear - multiple projects exist, but none fully replicate the shadcn philosophy. There's room for a well-executed version that Flutter developers will love.
