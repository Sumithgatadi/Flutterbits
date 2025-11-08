# Flutterbits: The Complete shadcn/ui to Flutter Conversion Guide

> Everything you need to build a production-ready Flutter port of shadcn/ui components

**Version**: 3.0
**Last Updated**: November 2025
**Status**: Production-Ready Specification
**Target**: MUI 6 / Material 3 Era

---

## 🎯 Executive Summary

Flutterbits brings the proven shadcn/ui philosophy to Flutter—a copy-paste component library where developers maintain complete ownership of their components. This guide contains **EVERYTHING** needed to convert shadcn/ui components to Flutter with exact visual fidelity and Material 3 compliance.

### Core Philosophy
- ✅ **True Copy-Paste**: Components copied to your codebase (not a package dependency)
- ✅ **Developer Ownership**: Modify, extend, and customize freely without vendor lock-in
- ✅ **Production-Ready**: Material 3 compliant, WCAG 2.2 accessible, performance-optimized
- ✅ **Cross-Platform**: iOS, Android, Web, macOS, Windows, Linux
- ✅ **MUI 6 Aligned**: Matching the latest Material Design standards

---

# PART 1: VISUAL DESIGN SPECIFICATIONS

## 📐 Design Measurement Tools & Techniques

### Tool 1: Browser DevTools Inspector

```
Steps:
1. Open shadcn/ui component page
2. Right-click → Inspect (or Cmd+Option+I)
3. Select element → Computed tab
4. Extract:
   - padding, margin
   - border-width, border-color, border-radius
   - font-size, font-weight, line-height
   - color, background-color
   - box-shadow, text-shadow
```

**Example - Button element inspection**:
```
Computed Styles:
- padding: 10px 16px
- border-radius: 6px
- background-color: hsl(222.2 47.4% 11.2%)  // #1e293b
- color: hsl(210 40% 98%)                    // #f1f5f9
- font-size: 14px
- font-weight: 500
- line-height: 24px
- box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px -1px rgba(0, 0, 0, 0.1)
```

### Tool 2: Figma Inspect Mode

```
Steps:
1. Open shadcn/ui Figma file (community)
2. Click component
3. Right panel → Inspect tab
4. Extract all properties:
   - Dimensions (width, height)
   - Spacing (padding, gap)
   - Typography
   - Effects (shadows, strokes)
   - Colors with opacity
```

### Tool 3: Screenshot Comparison

```
Setup:
1. Take web screenshot (1x scale, no zoom)
2. Take Flutter screenshot (same device size)
3. Use overlay tool to compare
4. Note pixel-level differences
```

---

## 🎨 Complete Color System (shadcn/ui 2025 + Material 3)

### shadcn/ui Default Theme (Zinc Scale)

```dart
// lib/design/tokens/color_tokens.dart
class ColorTokens {
  // Light Mode Primary
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color foregroundLight = Color(0xFF09090B);
  static const Color primaryLight = Color(0xFF18181B);

  // Dark Mode Primary
  static const Color backgroundDark = Color(0xFF09090B);
  static const Color foregroundDark = Color(0xFFFAFAFA);
  static const Color primaryDark = Color(0xFFFAFAFA);

  // Muted backgrounds
  static const Color muted = Color(0xFFF4F4F5);
  static const Color mutedForeground = Color(0xFF71717A);

  // Secondary
  static const Color secondary = Color(0xFFF4F4F5);
  static const Color secondaryForeground = Color(0xFF18181B);

  // Destructive (Error)
  static const Color destructive = Color(0xFFEF4444);
  static const Color destructiveForeground = Color(0xFFFAFAFA);

  // Accent (Interactive)
  static const Color accent = Color(0xFFF4F4F5);
  static const Color accentForeground = Color(0xFF18181B);

  // Borders & Inputs
  static const Color border = Color(0xFFE4E4E7);
  static const Color input = Color(0xFFE4E4E7);
  static const Color ring = Color(0xFF18181B);

  // Cards
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardForeground = Color(0xFF09090B);
}

// Zinc Neutral Scale (Complete 11-step)
class NeutralTokens {
  static const Color zinc50 = Color(0xFFFAFAFA);
  static const Color zinc100 = Color(0xFFF4F4F5);
  static const Color zinc200 = Color(0xFFE4E4E7);
  static const Color zinc300 = Color(0xFFD4D4D8);
  static const Color zinc400 = Color(0xFFA1A1AA);
  static const Color zinc500 = Color(0xFF71717A);
  static const Color zinc600 = Color(0xFF52525B);
  static const Color zinc700 = Color(0xFF3F3F46);
  static const Color zinc800 = Color(0xFF27272A);
  static const Color zinc900 = Color(0xFF18181B);
  static const Color zinc950 = Color(0xFF09090B);
}
```

### Material 3 Tonal Palettes (MUI 6 Aligned)

```dart
// Material 3 Dynamic Color System
class MD3Tokens {
  static const Color primary = Color(0xFF6750A4);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimaryContainer = Color(0xFF21005D);

  // Complete tonal palette (13 tones)
  static const Map<int, Color> primaryTonal = {
    0: Color(0xFF000000),
    10: Color(0xFF21005D),
    20: Color(0xFF381E72),
    30: Color(0xFF4F378B),
    40: Color(0xFF6750A4),
    50: Color(0xFF7F67BE),
    60: Color(0xFF9A82DB),
    70: Color(0xFFB69DF8),
    80: Color(0xFFD0BCFF),
    90: Color(0xFFEADDFF),
    95: Color(0xFFF6EDFF),
    99: Color(0xFFFFFBFE),
    100: Color(0xFFFFFFFF),
  };
}
```

### Color Conversion Reference

| HSL (shadcn/ui) | Hex | Flutter Color | Usage |
|-----------------|-----|---------------|-------|
| hsl(240 10% 3.9%) | #09090B | Color(0xFF09090B) | Foreground dark |
| hsl(0 0% 98%) | #FAFAFA | Color(0xFFFAFAFA) | Foreground light |
| hsl(240 5.9% 10%) | #18181B | Color(0xFF18181B) | Primary |
| hsl(240 4.8% 95.9%) | #F4F4F5 | Color(0xFFF4F4F5) | Muted |
| hsl(0 84.2% 60.2%) | #EF4444 | Color(0xFFEF4444) | Destructive |
| hsl(240 5.9% 90%) | #E4E4E7 | Color(0xFFE4E4E7) | Border |

---

## 📏 Spacing & Layout System

### Spacing Scale (8px Grid)

```dart
class SpacingTokens {
  // Base unit = 8px (matches Tailwind/MUI)
  static const double unit = 8.0;

  // Scale
  static const double xs = 4.0;   // 0.5 unit
  static const double sm = 8.0;   // 1 unit (p-2)
  static const double md = 12.0;  // 1.5 units (p-3)
  static const double lg = 16.0;  // 2 units (p-4)
  static const double xl = 24.0;  // 3 units (p-6)
  static const double xxl = 32.0; // 4 units (p-8)
  static const double xxxl = 48.0; // 6 units (p-12)
}

// Component-specific padding
class ComponentPadding {
  // Button
  static const EdgeInsets buttonSm = EdgeInsets.symmetric(horizontal: 12, vertical: 6);
  static const EdgeInsets buttonMd = EdgeInsets.symmetric(horizontal: 16, vertical: 10);
  static const EdgeInsets buttonLg = EdgeInsets.symmetric(horizontal: 24, vertical: 12);

  // Input
  static const EdgeInsets inputSm = EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  static const EdgeInsets inputMd = EdgeInsets.symmetric(horizontal: 14, vertical: 10);
  static const EdgeInsets inputLg = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  // Card
  static const EdgeInsets card = EdgeInsets.all(24);
  static const EdgeInsets cardCompact = EdgeInsets.all(16);
}
```

### Border Radius System

```dart
class RadiusTokens {
  static const double none = 0;       // rounded-none
  static const double xs = 2.0;       // rounded-sm
  static const double sm = 4.0;       // rounded
  static const double md = 6.0;       // rounded-md (default)
  static const double lg = 8.0;       // rounded-lg
  static const double xl = 12.0;      // rounded-xl
  static const double xxl = 16.0;     // rounded-2xl
  static const double xxxl = 24.0;    // rounded-3xl
  static const double full = 9999.0;  // rounded-full
}
```

---

## ✍️ Typography System (Material 3 + shadcn/ui)

### Complete Type Scale

```dart
class TypographyTokens {
  // Display (57-45-36)
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 1.16,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.22,
  );

  // Headlines (32-28-24)
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.29,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  // Body (16-14-12)
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // Labels (14-12-11)
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );
}
```

---

## 🌫️ Shadows & Elevation

```dart
class ElevationTokens {
  // Level 1 - Cards, lifted elements
  static final List<BoxShadow> sm = [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  // Level 2 - Dropdowns, hover states
  static final List<BoxShadow> md = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  // Level 3 - Modals, dialogs
  static final List<BoxShadow> lg = [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  // Level 4 - Popovers, tooltips
  static final List<BoxShadow> xl = [
    BoxShadow(
      color: Colors.black.withOpacity(0.16),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
}
```

---

## 🎬 Animation Specifications

### Material 3 Motion (MUI 6 Aligned)

```dart
class AnimationTokens {
  // Durations (Material 3 standard)
  static const Duration short1 = Duration(milliseconds: 50);
  static const Duration short2 = Duration(milliseconds: 100);
  static const Duration short3 = Duration(milliseconds: 150);
  static const Duration short4 = Duration(milliseconds: 200);
  static const Duration medium1 = Duration(milliseconds: 250);
  static const Duration medium2 = Duration(milliseconds: 300);
  static const Duration medium3 = Duration(milliseconds: 350);
  static const Duration medium4 = Duration(milliseconds: 400);
  static const Duration long1 = Duration(milliseconds: 450);
  static const Duration long2 = Duration(milliseconds: 500);
  static const Duration long3 = Duration(milliseconds: 550);
  static const Duration long4 = Duration(milliseconds: 600);

  // Easing curves (Material 3 emphasis)
  static const Curve emphasized = Cubic(0.2, 0.0, 0.0, 1.0);
  static const Curve emphasizedAccelerate = Cubic(0.3, 0.0, 0.8, 0.15);
  static const Curve emphasizedDecelerate = Cubic(0.05, 0.7, 0.1, 1.0);
  static const Curve standard = Cubic(0.2, 0.0, 0.0, 1.0);
  static const Curve standardAccelerate = Cubic(0.3, 0.0, 1.0, 1.0);
  static const Curve standardDecelerate = Cubic(0.0, 0.0, 0.0, 1.0);
}
```

---

# PART 2: COMPONENT CONVERSION METHODOLOGY

## 🔄 Step-by-Step Conversion Process

### Phase 1: Analysis (Study Original)

1. **Visit shadcn/ui Documentation**
   - URL: https://ui.shadcn.com/docs/components/[component]
   - Extract: variants, sizes, states, props

2. **Examine Source Code**
   - GitHub: shadcn-ui/ui/tree/main/apps/www/registry/new-york/
   - Understand: React structure, CSS classes, Tailwind utilities

3. **Review Radix UI Foundation**
   - URL: https://www.radix-ui.com/docs/primitives/
   - Note: Accessibility features, keyboard interactions, ARIA

4. **Create Specification Document**
   ```markdown
   # [Component] Specification

   ## Variants
   - default: [colors, usage]
   - secondary: [colors, usage]

   ## Sizes
   - sm: [dimensions]
   - md: [dimensions]
   - lg: [dimensions]

   ## States
   - Normal: [appearance]
   - Hover: [changes]
   - Active: [changes]
   - Disabled: [changes]
   - Focus: [changes]
   ```

### Phase 2: Implementation

```dart
// lib/components/ui/[component].dart

import 'package:flutter/material.dart';
import '../../design/tokens/color_tokens.dart';
import '../../design/tokens/spacing_tokens.dart';
import '../../design/tokens/typography_tokens.dart';

// 1. Define Enums
enum ComponentVariant { primary, secondary, destructive, outline, ghost }
enum ComponentSize { sm, md, lg }

// 2. Create StatefulWidget (if interactive)
class Component extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final ComponentVariant variant;
  final ComponentSize size;
  final bool isLoading;
  final bool disabled;

  const Component({
    Key? key,
    required this.child,
    this.onPressed,
    this.variant = ComponentVariant.primary,
    this.size = ComponentSize.md,
    this.isLoading = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  State<Component> createState() => _ComponentState();
}

class _ComponentState extends State<Component>
    with SingleTickerProviderStateMixin {

  // Animation controllers
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // Interactive states
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: AnimationTokens.short3,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: AnimationTokens.emphasized,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = _getColors(theme);
    final padding = _getPadding();
    final textStyle = _getTextStyle(theme);

    return Semantics(
      button: true,
      enabled: !widget.disabled && widget.onPressed != null,
      label: 'Component',
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: widget.disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) => Transform.scale(
                scale: _scaleAnimation.value,
                child: AnimatedContainer(
                  duration: AnimationTokens.short3,
                  padding: padding,
                  decoration: BoxDecoration(
                    color: colors.background,
                    border: colors.border != null
                        ? Border.all(color: colors.border!, width: 1)
                        : null,
                    borderRadius: BorderRadius.circular(RadiusTokens.md),
                    boxShadow: _getShadows(),
                  ),
                  child: DefaultTextStyle(
                    style: textStyle.copyWith(color: colors.foreground),
                    child: widget.isLoading
                        ? _buildLoadingIndicator(colors.foreground)
                        : widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods
  ({Color background, Color foreground, Color? border}) _getColors(
    ThemeData theme,
  ) {
    // Return colors based on variant
    return switch (widget.variant) {
      ComponentVariant.primary => (
        background: ColorTokens.primaryLight,
        foreground: ColorTokens.backgroundLight,
        border: null,
      ),
      // ... other variants
    };
  }

  EdgeInsets _getPadding() {
    return switch (widget.size) {
      ComponentSize.sm => ComponentPadding.buttonSm,
      ComponentSize.md => ComponentPadding.buttonMd,
      ComponentSize.lg => ComponentPadding.buttonLg,
    };
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
```

### Phase 3: Testing

#### Widget Tests
```dart
// test/components/[component]_test.dart
void main() {
  group('Component', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Component(child: Text('Test')),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('handles interaction', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Component(
              onPressed: () => pressed = true,
              child: Text('Click'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Component));
      await tester.pumpAndSettle();

      expect(pressed, true);
    });
  });
}
```

#### Golden Tests (Visual Regression)
```dart
// test/golden/[component]_golden_test.dart
void main() {
  testWidgets('Component golden test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: Center(
            child: Component(
              variant: ComponentVariant.primary,
              child: Text('Primary'),
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(Component),
      matchesGoldenFile('component_primary.png'),
    );
  });
}
```

#### Accessibility Tests
```dart
// test/accessibility/[component]_a11y_test.dart
void main() {
  testWidgets('meets WCAG guidelines', (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Component(child: Text('Accessible')),
        ),
      ),
    );

    // Check for semantic properties
    expect(tester.getSemantics(find.byType(Component)),
      matchesSemantics(
        label: 'Component',
        isButton: true,
        hasEnabledState: true,
        isEnabled: true,
      ),
    );

    handle.dispose();
  });

  testWidgets('meets contrast requirements', (tester) async {
    // Test color contrast ratios
    final contrast = getContrastRatio(
      ColorTokens.primaryLight,
      ColorTokens.backgroundLight,
    );

    expect(contrast, greaterThanOrEqualTo(4.5)); // WCAG AA
  });
}
```

---

# PART 3: COMPONENT SPECIFICATIONS

## Component Development Tiers

### Tier 0: Foundation (No Dependencies)
1. **Badge** - Status indicators
2. **Avatar** - User representations
3. **Alert** - Information messages

### Tier 1: Core Interactive
1. **Button** - All variants (primary, secondary, destructive, outline, ghost, link)
2. **Input** - Text input fields
3. **Switch** - Toggle controls
4. **Checkbox** - Selection controls
5. **Radio** - Single selection

### Tier 2: Containers
1. **Card** - Content containers
2. **Dialog** - Modal dialogs
3. **Accordion** - Collapsible content

### Tier 3: Complex
1. **Select** - Dropdown selection
2. **Dropdown Menu** - Actions menu
3. **Context Menu** - Right-click menu
4. **Command** - Command palette
5. **Combobox** - Autocomplete

### Tier 4: Advanced
1. **Data Table** - Data display
2. **Tabs** - Tab navigation
3. **Toast** - Notifications
4. **Carousel** - Image sliders
5. **Form** - Form management

---

## 📋 Button Component - Complete Specification

```dart
/*
═══════════════════════════════════════════════════════════════════════════════
                            BUTTON COMPONENT SPEC
═══════════════════════════════════════════════════════════════════════════════

VARIANTS:
  1. Primary (default)
     - Background: #18181B (zinc-900)
     - Text: #FAFAFA (zinc-50)
     - Border: none
     - Hover: opacity 90%
     - Active: scale 95%, opacity 80%

  2. Secondary
     - Background: #F4F4F5 (zinc-100)
     - Text: #18181B (zinc-900)
     - Border: none
     - Hover: opacity 90%
     - Active: scale 95%

  3. Destructive
     - Background: #EF4444 (red-500)
     - Text: #FAFAFA (white)
     - Border: none
     - Hover: opacity 90%

  4. Outline
     - Background: transparent
     - Text: #18181B
     - Border: 1px solid #E4E4E7 (zinc-200)
     - Hover: background #FAFAFA
     - Active: scale 95%

  5. Ghost
     - Background: transparent
     - Text: #18181B
     - Border: none
     - Hover: background #F4F4F5
     - Active: scale 95%

  6. Link
     - Background: transparent
     - Text: #18181B (with underline)
     - Border: none
     - Hover: underline visible
     - Active: opacity 80%

SIZES:
  Small (sm):
    - Height: 32px
    - Padding: 6px 12px
    - Font Size: 12px
    - Font Weight: 500
    - Border Radius: 6px

  Medium (md) - DEFAULT:
    - Height: 40px
    - Padding: 10px 16px
    - Font Size: 14px
    - Font Weight: 500
    - Border Radius: 6px

  Large (lg):
    - Height: 48px
    - Padding: 12px 24px
    - Font Size: 16px
    - Font Weight: 500
    - Border Radius: 6px

  Icon:
    - Small: 32x32px
    - Medium: 40x40px
    - Large: 48x48px

INTERACTIVE STATES:
  - Default: No transformation
  - Hover: opacity 0.9 (90%)
  - Active/Press: scale 0.95 (95%), opacity 0.8 (80%)
  - Disabled: opacity 0.5, cursor not-allowed
  - Focus: ring 2px offset 2px (ring color)
  - Loading: Show spinner, disabled state

ANIMATIONS:
  - Transition: All changes smoothly over 150ms
  - Easing: cubic-bezier(0.2, 0, 0, 1)
  - Properties: opacity, scale, background-color

SHADOWS:
  - Primary variant: Box shadow on hover
  - Others: No shadow

ACCESSIBILITY:
  - Semantic button role
  - Keyboard navigation support (Tab, Enter, Space)
  - Screen reader label
  - High contrast focus indicator
  - Min 44px touch target (iOS guidelines)
  - 48px touch target (Android/Material)

═══════════════════════════════════════════════════════════════════════════════
*/
```

---

# PART 4: THEME SYSTEM & ARCHITECTURE

## Material 3 Theme Configuration

```dart
// lib/design/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import '../tokens/color_tokens.dart';
import '../tokens/typography_tokens.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme({Color? seedColor}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor ?? ColorTokens.primaryLight,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme.copyWith(
        background: ColorTokens.backgroundLight,
        onBackground: ColorTokens.foregroundLight,
        surface: ColorTokens.card,
        onSurface: ColorTokens.cardForeground,
        primary: ColorTokens.primaryLight,
        onPrimary: ColorTokens.backgroundLight,
        secondary: ColorTokens.secondary,
        onSecondary: ColorTokens.secondaryForeground,
        error: ColorTokens.destructive,
        onError: ColorTokens.destructiveForeground,
        outline: ColorTokens.border,
      ),
      textTheme: _buildTextTheme(Brightness.light),
      elevatedButtonTheme: _elevatedButtonTheme(),
      textButtonTheme: _textButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
      cardTheme: _cardTheme(),
      dialogTheme: _dialogTheme(),
      dividerTheme: _dividerTheme(),
      // ... other component themes
    );
  }

  // Dark Theme
  static ThemeData darkTheme({Color? seedColor}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor ?? ColorTokens.primaryDark,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme.copyWith(
        background: ColorTokens.backgroundDark,
        onBackground: ColorTokens.foregroundDark,
        surface: ColorTokens.zinc900,
        onSurface: ColorTokens.zinc50,
        primary: ColorTokens.primaryDark,
        onPrimary: ColorTokens.zinc950,
        secondary: ColorTokens.zinc800,
        onSecondary: ColorTokens.zinc100,
        error: ColorTokens.destructive,
        onError: ColorTokens.destructiveForeground,
        outline: ColorTokens.zinc700,
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      // ... component themes
    );
  }

  // Dynamic Theme (Material You)
  static Future<ThemeData> dynamicTheme(
    BuildContext context,
    Brightness brightness,
  ) async {
    return DynamicColorPlugin.getCorePalette().then((corePalette) {
      final colorScheme = corePalette?.toColorScheme(brightness: brightness);

      if (colorScheme == null) {
        return brightness == Brightness.light
            ? lightTheme()
            : darkTheme();
      }

      return ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: _buildTextTheme(brightness),
        // ... component themes
      );
    });
  }

  // Typography
  static TextTheme _buildTextTheme(Brightness brightness) {
    return TextTheme(
      displayLarge: TypographyTokens.displayLarge,
      displayMedium: TypographyTokens.displayMedium,
      displaySmall: TypographyTokens.displaySmall,
      headlineLarge: TypographyTokens.headlineLarge,
      headlineMedium: TypographyTokens.headlineMedium,
      headlineSmall: TypographyTokens.headlineSmall,
      titleLarge: TypographyTokens.headlineMedium,
      titleMedium: TypographyTokens.headlineSmall,
      bodyLarge: TypographyTokens.bodyLarge,
      bodyMedium: TypographyTokens.bodyMedium,
      bodySmall: TypographyTokens.bodySmall,
      labelLarge: TypographyTokens.labelLarge,
      labelMedium: TypographyTokens.labelMedium,
      labelSmall: TypographyTokens.labelSmall,
    ).apply(
      bodyColor: brightness == Brightness.light
          ? ColorTokens.foregroundLight
          : ColorTokens.foregroundDark,
      displayColor: brightness == Brightness.light
          ? ColorTokens.foregroundLight
          : ColorTokens.foregroundDark,
    );
  }

  // Component Themes
  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(64, 40),
        padding: ComponentPadding.buttonMd,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusTokens.md),
        ),
        elevation: 0,
        textStyle: TypographyTokens.labelLarge,
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: ColorTokens.backgroundLight,
      contentPadding: ComponentPadding.inputMd,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.md),
        borderSide: BorderSide(color: ColorTokens.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.md),
        borderSide: BorderSide(color: ColorTokens.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.md),
        borderSide: BorderSide(color: ColorTokens.ring, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.md),
        borderSide: BorderSide(color: ColorTokens.destructive),
      ),
    );
  }
}
```

---

# PART 5: CLI IMPLEMENTATION

## Flutterbits CLI Tool

```dart
// packages/flutterbits_cli/lib/src/commands/init_command.dart
import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

class InitCommand extends Command<int> {
  @override
  String get description => 'Initialize Flutterbits in your Flutter project';

  @override
  String get name => 'init';

  InitCommand() {
    argParser
      ..addOption('style',
        help: 'Design style to use',
        allowed: ['default', 'new-york', 'material'],
        defaultsTo: 'default',
      )
      ..addFlag('force',
        help: 'Overwrite existing files',
        negatable: false,
      );
  }

  @override
  Future<int> run() async {
    final logger = Logger();

    // 1. Check for Flutter project
    if (!await _isFlutterProject()) {
      logger.err('❌ Not in a Flutter project directory');
      return ExitCode.software.code;
    }

    // 2. Create directory structure
    final directories = [
      'lib/design/tokens',
      'lib/design/theme',
      'lib/design/primitives',
      'lib/components/ui',
      'lib/components/layout',
      'lib/components/composite',
    ];

    for (final dir in directories) {
      await Directory(dir).create(recursive: true);
      logger.detail('📁 Created $dir');
    }

    // 3. Copy design tokens
    await _copyDesignTokens(logger);

    // 4. Setup theme
    await _setupTheme(logger);

    // 5. Update pubspec.yaml
    await _updatePubspec(logger);

    logger.success('✅ Flutterbits initialized successfully!');
    logger.info('');
    logger.info('Next steps:');
    logger.info('  1. Run: flutter pub get');
    logger.info('  2. Add components: flutterbits add button');
    logger.info('  3. Import theme: import "design/theme/app_theme.dart"');

    return ExitCode.success.code;
  }

  Future<bool> _isFlutterProject() async {
    return File('pubspec.yaml').exists() &&
           Directory('lib').exists();
  }

  Future<void> _copyDesignTokens(Logger logger) async {
    // Copy token files from templates
    final tokenFiles = [
      'color_tokens.dart',
      'typography_tokens.dart',
      'spacing_tokens.dart',
      'radius_tokens.dart',
      'elevation_tokens.dart',
      'animation_tokens.dart',
    ];

    for (final file in tokenFiles) {
      // Copy from brick templates
      logger.detail('📝 Created lib/design/tokens/$file');
    }
  }
}

// packages/flutterbits_cli/lib/src/commands/add_command.dart
class AddCommand extends Command<int> {
  @override
  String get description => 'Add a component to your project';

  @override
  String get name => 'add';

  @override
  Future<int> run() async {
    final logger = Logger();
    final componentName = argResults?.rest.firstOrNull;

    if (componentName == null) {
      logger.err('❌ Please specify a component name');
      logger.info('Example: flutterbits add button');
      return ExitCode.usage.code;
    }

    // Component registry
    final registry = {
      'button': ButtonTemplate(),
      'input': InputTemplate(),
      'card': CardTemplate(),
      'badge': BadgeTemplate(),
      'avatar': AvatarTemplate(),
      'alert': AlertTemplate(),
      'switch': SwitchTemplate(),
      'checkbox': CheckboxTemplate(),
      'dialog': DialogTemplate(),
      'select': SelectTemplate(),
      // ... more components
    };

    final template = registry[componentName.toLowerCase()];

    if (template == null) {
      logger.err('❌ Component "$componentName" not found');
      logger.info('Available components:');
      registry.keys.forEach((name) => logger.info('  - $name'));
      return ExitCode.software.code;
    }

    // Check dependencies
    final missingDeps = await _checkDependencies(template.dependencies);
    if (missingDeps.isNotEmpty) {
      logger.warn('⚠️  Missing dependencies: ${missingDeps.join(", ")}');
      logger.info('Run: flutter pub add ${missingDeps.join(" ")}');
    }

    // Copy component files
    await _copyComponentFiles(componentName, template, logger);

    logger.success('✅ Added $componentName component');
    logger.info('');
    logger.info('Usage:');
    logger.info('  import "components/ui/$componentName.dart";');
    logger.info('');
    logger.info('  ${template.example}');

    return ExitCode.success.code;
  }
}
```

---

# PART 6: TESTING STRATEGY

## Comprehensive Testing Approach

### 1. Unit Tests (Logic)
```dart
test('color contrast meets WCAG', () {
  final contrast = getContrastRatio(
    ColorTokens.primaryLight,
    ColorTokens.backgroundLight,
  );
  expect(contrast, greaterThanOrEqualTo(4.5));
});
```

### 2. Widget Tests (Behavior)
```dart
testWidgets('component responds to interaction', (tester) async {
  // Test user interactions
});
```

### 3. Golden Tests (Visual)
```dart
testWidgets('component appearance matches design', (tester) async {
  // Visual regression testing
});
```

### 4. Integration Tests (E2E)
```dart
testWidgets('full user flow works', (tester) async {
  // Test complete user journeys
});
```

### 5. Performance Tests
```dart
test('renders in <16ms', () {
  final stopwatch = Stopwatch()..start();
  // Render component
  stopwatch.stop();
  expect(stopwatch.elapsedMilliseconds, lessThan(16));
});
```

### 6. Accessibility Tests
```dart
testWidgets('meets accessibility guidelines', (tester) async {
  await expectMeetsAccessibilityGuidelines(
    tester,
    textContrastGuideline,
    androidTapTargetGuideline,
    iOSTapTargetGuideline,
    labeledTapTargetGuideline,
  );
});
```

---

# PART 7: ACCESSIBILITY & WCAG 2.2

## Accessibility Requirements

### Color Contrast
- **Normal text**: 4.5:1 minimum
- **Large text** (18pt+): 3:1 minimum
- **UI components**: 3:1 minimum

### Touch Targets
- **iOS**: 44x44dp minimum
- **Android**: 48x48dp minimum
- **Web**: 44x44px minimum

### Keyboard Navigation
```dart
Focus(
  onKey: (node, event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter) ||
        event.isKeyPressed(LogicalKeyboardKey.space)) {
      _handleActivation();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  },
  child: ...,
)
```

### Screen Reader Support
```dart
Semantics(
  label: 'Submit button',
  hint: 'Double tap to submit the form',
  button: true,
  enabled: true,
  child: ...,
)
```

### Testing Accessibility
```bash
# iOS VoiceOver
Settings > Accessibility > VoiceOver

# Android TalkBack
Settings > Accessibility > TalkBack

# Flutter Testing
flutter test test/accessibility/
```

---

# PART 8: PERFORMANCE OPTIMIZATION

## Performance Targets
- **Frame Rate**: 60-120 FPS
- **Render Time**: <16ms per frame
- **Memory**: <50MB baseline
- **Bundle Size**: <5MB per component

## Optimization Techniques

### 1. Const Constructors
```dart
const Button(  // const prevents rebuilds
  child: const Text('Click'),  // const all the way down
)
```

### 2. Efficient Rebuilds
```dart
class OptimizedWidget extends StatelessWidget {
  const OptimizedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(  // Isolate repaints
      child: ...,
    );
  }
}
```

### 3. Lazy Loading
```dart
// Load components on demand
final component = await ComponentRegistry.load('button');
```

### 4. Memory Management
```dart
@override
void dispose() {
  _controller.dispose();  // Clean up resources
  _focusNode.dispose();
  super.dispose();
}
```

---

# PART 9: PLATFORM ADAPTATIONS

## Platform-Specific Adjustments

```dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class PlatformAware extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Web
    if (kIsWeb) {
      return _buildWebVersion();
    }

    // Mobile
    if (Platform.isIOS) {
      return _buildIOSVersion();
    } else if (Platform.isAndroid) {
      return _buildAndroidVersion();
    }

    // Desktop
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      return _buildDesktopVersion();
    }

    return _buildDefaultVersion();
  }
}
```

---

# PART 10: PRODUCTION CHECKLIST

## Before Component Release

### Design Verification
- [ ] Visual matches shadcn/ui exactly
- [ ] All variants implemented
- [ ] All sizes working
- [ ] All states functional
- [ ] Dark mode support
- [ ] Responsive on all screen sizes

### Code Quality
- [ ] >80% test coverage
- [ ] No analyzer warnings
- [ ] Documentation complete
- [ ] Examples provided
- [ ] API documented

### Performance
- [ ] Renders <16ms (60 FPS)
- [ ] No memory leaks
- [ ] Efficient rebuilds
- [ ] Bundle size optimized

### Accessibility
- [ ] WCAG 2.2 AA compliant
- [ ] Keyboard navigable
- [ ] Screen reader tested
- [ ] Focus indicators visible
- [ ] Touch targets adequate

### Cross-Platform
- [ ] iOS tested
- [ ] Android tested
- [ ] Web tested
- [ ] Desktop tested
- [ ] Responsive layouts

---

## 🎯 Quick Reference

### Component Conversion Formula
```
shadcn/ui Component → Analyze → Design Tokens → Flutter Implementation → Test → Release
```

### File Structure
```
lib/
├── design/
│   ├── tokens/       # Design system tokens
│   ├── theme/        # Theme configuration
│   └── primitives/   # Base components
├── components/
│   ├── ui/          # shadcn/ui components
│   ├── layout/      # Layout helpers
│   └── composite/   # Complex components
```

### Import Pattern
```dart
import 'package:flutterbits/components/ui/button.dart';
import 'package:flutterbits/design/tokens/color_tokens.dart';
import 'package:flutterbits/design/theme/app_theme.dart';
```

---

## 📚 Resources

### Essential Links
- **shadcn/ui**: https://ui.shadcn.com
- **Material 3**: https://m3.material.io
- **Flutter Docs**: https://docs.flutter.dev
- **MUI 6**: https://mui.com
- **Radix UI**: https://radix-ui.com
- **WCAG 2.2**: https://www.w3.org/WAI/WCAG22/quickref/

### Tools
- **Figma**: Component inspection
- **Chrome DevTools**: CSS extraction
- **Flutter DevTools**: Performance profiling
- **Lighthouse**: Accessibility audit

---

**End of Complete Conversion Guide**
**Total Sections**: 10
**Status**: Production-Ready
**Version**: 3.0
**Last Updated**: November 2025