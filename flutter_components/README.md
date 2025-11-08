# Flutterbits - Flutter Components

This directory contains Flutter implementations of shadcn/ui components, following Material 3 design guidelines and the Flutterbits conversion methodology.

## 📁 Directory Structure

```
flutter_components/
├── lib/
│   ├── components/
│   │   ├── ui/              # Core UI components (shadcn/ui ports)
│   │   │   └── alert_dialog.dart
│   │   ├── examples/        # Demo implementations
│   │   │   └── alert_dialog_demo.dart
│   │   ├── layout/          # Layout helpers
│   │   └── composite/       # Complex composite components
│   ├── design/
│   │   ├── tokens/          # Design system tokens
│   │   ├── theme/           # Theme configuration
│   │   └── primitives/      # Base components
│   └── utils/               # Utility functions
└── README.md
```

## 🚀 Getting Started

### Using a Component

1. **Copy the component file** to your Flutter project:
   ```
   cp flutter_components/lib/components/ui/alert_dialog.dart your_project/lib/components/ui/
   ```

2. **Import and use** in your Flutter app:
   ```dart
   import 'package:your_app/components/ui/alert_dialog.dart';

   FlutterAlertDialog(
     trigger: ElevatedButton(
       onPressed: () {},
       child: const Text('Show Alert'),
     ),
     content: AlertDialogContent(
       title: const AlertDialogTitle(
         child: Text('Are you absolutely sure?'),
       ),
       description: const AlertDialogDescription(
         child: Text('This action cannot be undone.'),
       ),
       actions: Builder(
         builder: (context) => AlertDialogFooter(
           children: [
             AlertDialogCancel(
               onPressed: () => Navigator.of(context).pop(),
               child: const Text('Cancel'),
             ),
             AlertDialogAction(
               onPressed: () => Navigator.of(context).pop(),
               child: const Text('Continue'),
             ),
           ],
         ),
       ),
     ),
   )
   ```

3. **Ensure Material 3 is enabled** in your app:
   ```dart
   MaterialApp(
     theme: ThemeData(
       useMaterial3: true,
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
     ),
   )
   ```

## 📦 Available Components

### UI Components

| Component | Status | File | Documentation |
|-----------|--------|------|---------------|
| Alert Dialog | ✅ Complete | `ui/alert_dialog.dart` | [Docs](../apps/v4/content/docs/flutter-components/alert-dialog.mdx) |
| Button | 🚧 Coming soon | - | - |
| Input | 🚧 Coming soon | - | - |
| Card | 🚧 Coming soon | - | - |

## 🎨 Design Philosophy

All components follow these principles:

1. **True Copy-Paste**: Components are copied to your codebase, not installed as a package
2. **Material 3 Compliant**: Follows the latest Material Design 3 specifications
3. **shadcn/ui Fidelity**: Visual appearance matches shadcn/ui exactly
4. **Accessibility First**: WCAG 2.2 AA compliant with proper semantics
5. **Responsive**: Adapts to different screen sizes and orientations
6. **Customizable**: Easy to modify and extend for your needs

## 📐 Design Specifications

Components are built following the [Complete Conversion Guide](../COMPLETE_CONVERSION_GUIDE.md):

- **Color System**: Material 3 tonal palettes + shadcn/ui zinc scale
- **Spacing**: 8px grid system
- **Typography**: Material 3 type scale
- **Animations**: 200ms duration with ease-out curves
- **Border Radius**: 8px default (matches shadcn/ui)
- **Shadows**: Material 3 elevation levels

## 🧪 Running Examples

Each component has a corresponding demo file in `lib/components/examples/`:

```bash
# Create a new Flutter project
flutter create demo_app
cd demo_app

# Copy the component and demo
cp ../flutter_components/lib/components/ui/alert_dialog.dart lib/components/ui/
cp ../flutter_components/lib/components/examples/alert_dialog_demo.dart lib/

# Update main.dart to import the demo
# Then run
flutter run
```

## ♿ Accessibility

All components include:

- ✅ Semantic labels and roles
- ✅ Keyboard navigation support
- ✅ Screen reader compatibility
- ✅ Focus management
- ✅ WCAG 2.2 AA color contrast
- ✅ Touch target sizes (48x48dp minimum)

## 🧩 Component Structure

Each component follows this structure:

```dart
/*
═══════════════════════════════════════════════════════════════
                    COMPONENT NAME
═══════════════════════════════════════════════════════════════

Description and specifications

VISUAL SPECIFICATIONS:
  - Design details
  - Measurements
  - Colors
  - Animations

ACCESSIBILITY:
  - a11y features
  - ARIA equivalents
═══════════════════════════════════════════════════════════════
*/

import 'package:flutter/material.dart';

/// Main component class with full documentation
class ComponentName extends StatelessWidget {
  // Implementation
}

// ═══════════════════════════════════════════════════════════════
// EXAMPLE USAGE
// ═══════════════════════════════════════════════════════════════

/// Example documentation with code samples
```

## 🔧 Customization

### Theming

Components automatically adapt to your app's theme:

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.light,
    ),
  ),
  darkTheme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.dark,
    ),
  ),
)
```

### Component Modification

Since you own the code, you can:

1. Change colors, sizes, or animations
2. Add new variants or states
3. Extend functionality
4. Remove features you don't need

## 📚 Resources

- [Complete Conversion Guide](../COMPLETE_CONVERSION_GUIDE.md) - Detailed methodology
- [shadcn/ui Documentation](https://ui.shadcn.com) - Original React components
- [Material 3 Guidelines](https://m3.material.io) - Design system reference
- [Flutter Documentation](https://docs.flutter.dev) - Flutter framework docs

## 🤝 Contributing

This is a reference implementation. To contribute:

1. Follow the conversion guide methodology
2. Ensure Material 3 compliance
3. Match shadcn/ui visual specifications
4. Include comprehensive documentation
5. Add demo examples
6. Test for accessibility

## 📄 License

See [LICENSE.md](../LICENSE.md) for details.

## 🙏 Credits

- **shadcn/ui**: Original component library by [@shadcn](https://twitter.com/shadcn)
- **Radix UI**: Unstyled primitives that inspired the architecture
- **Material Design**: Google's design system
- **Flutter Team**: Amazing framework and tools

---

**Version**: 1.0.0
**Last Updated**: November 2025
**Status**: Active Development
