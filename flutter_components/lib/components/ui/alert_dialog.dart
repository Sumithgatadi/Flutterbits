/*
═══════════════════════════════════════════════════════════════════════════════
                        ALERT DIALOG COMPONENT SPEC
═══════════════════════════════════════════════════════════════════════════════

A modal dialog that interrupts the user with important content and expects a response.

Based on shadcn/ui Alert Dialog component
Radix UI: https://www.radix-ui.com/docs/primitives/components/alert-dialog

VISUAL SPECIFICATIONS:
  Overlay:
    - Background: black with 50% opacity
    - Full screen coverage
    - Fade in/out animation (200ms)

  Content:
    - Background: background color
    - Max width: 512px (sm:max-w-lg)
    - Max width mobile: calc(100% - 32px)
    - Padding: 24px
    - Border radius: 8px
    - Border: 1px solid border color
    - Shadow: lg elevation
    - Position: center of screen
    - Animations: fade + zoom (95% to 100%, 200ms)

  Header:
    - Layout: Column
    - Gap: 8px
    - Alignment: center (mobile), left (desktop)

  Footer:
    - Layout: Column-reverse (mobile), Row (desktop)
    - Gap: 8px
    - Justify: end (desktop)

  Title:
    - Font size: 18px
    - Font weight: 600 (semibold)
    - Line height: 1.33

  Description:
    - Font size: 14px
    - Font weight: 400
    - Color: muted-foreground
    - Line height: 1.43

  Action Button:
    - Variant: Primary
    - Full width on mobile

  Cancel Button:
    - Variant: Outline
    - Full width on mobile

ACCESSIBILITY:
  - Semantic dialog role
  - Focus trap when open
  - Escape key to dismiss
  - Screen reader announcements
  - Focus management (returns to trigger)
  - ARIA labels and descriptions

═══════════════════════════════════════════════════════════════════════════════
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Alert Dialog root - manages the dialog state and visibility
class FlutterAlertDialog extends StatelessWidget {
  const FlutterAlertDialog({
    super.key,
    required this.trigger,
    required this.content,
    this.barrierDismissible = true,
    this.barrierColor,
    this.onOpenChanged,
  });

  /// Widget that triggers the dialog when tapped
  final Widget trigger;

  /// The content of the dialog
  final Widget content;

  /// Whether tapping the barrier dismisses the dialog
  final bool barrierDismissible;

  /// Color of the modal barrier
  final Color? barrierColor;

  /// Callback when dialog open state changes
  final ValueChanged<bool>? onOpenChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        onOpenChanged?.call(true);
        await showDialog(
          context: context,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.5),
          builder: (context) => content,
        );
        if (context.mounted) {
          onOpenChanged?.call(false);
        }
      },
      child: trigger,
    );
  }
}

/// Alert Dialog Content - the main dialog container
class AlertDialogContent extends StatefulWidget {
  const AlertDialogContent({
    super.key,
    this.title,
    this.description,
    this.actions,
    this.maxWidth = 512.0,
    this.padding,
    this.gap = 16.0,
    this.children,
  });

  /// Dialog title widget
  final Widget? title;

  /// Dialog description widget
  final Widget? description;

  /// Action buttons (typically Cancel and Confirm)
  final Widget? actions;

  /// Maximum width of the dialog
  final double maxWidth;

  /// Content padding (default: 24px)
  final EdgeInsets? padding;

  /// Gap between elements
  final double gap;

  /// Custom children (if not using title/description/actions)
  final List<Widget>? children;

  @override
  State<AlertDialogContent> createState() => _AlertDialogContentState();
}

class _AlertDialogContentState extends State<AlertDialogContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    _setupAnimations();

    // Request focus after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusScopeNode.requestFocus();
    });
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  void _handleEscape() async {
    await _animationController.reverse();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 640;

    // Calculate max width (100% - 32px margin on mobile)
    final maxWidth = isSmallScreen
        ? mediaQuery.size.width - 32
        : widget.maxWidth;

    return FocusScope(
      node: _focusScopeNode,
      autofocus: true,
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.escape) {
            _handleEscape();
          }
        },
        child: Semantics(
          label: 'Alert Dialog',
          scopesRoute: true,
          namesRoute: true,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Dialog(
                  backgroundColor: colorScheme.surface,
                  elevation: 24,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: colorScheme.outline.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxWidth,
                    ),
                    child: Padding(
                      padding: widget.padding ?? const EdgeInsets.all(24),
                      child: widget.children != null
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: widget.children!,
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (widget.title != null ||
                                    widget.description != null)
                                  AlertDialogHeader(
                                    title: widget.title,
                                    description: widget.description,
                                    gap: 8,
                                  ),
                                if (widget.title != null ||
                                    widget.description != null)
                                  SizedBox(height: widget.gap),
                                if (widget.actions != null) widget.actions!,
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Alert Dialog Header - contains title and description
class AlertDialogHeader extends StatelessWidget {
  const AlertDialogHeader({
    super.key,
    this.title,
    this.description,
    this.gap = 8.0,
    this.centerOnMobile = true,
  });

  final Widget? title;
  final Widget? description;
  final double gap;
  final bool centerOnMobile;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 640;
    final alignment = centerOnMobile && isSmallScreen
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centerOnMobile && isSmallScreen
        ? TextAlign.center
        : TextAlign.start;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        if (title != null)
          DefaultTextStyle(
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.33,
                ),
            textAlign: textAlign,
            child: title!,
          ),
        if (title != null && description != null) SizedBox(height: gap),
        if (description != null)
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
            textAlign: textAlign,
            child: description!,
          ),
      ],
    );
  }
}

/// Alert Dialog Footer - contains action buttons
class AlertDialogFooter extends StatelessWidget {
  const AlertDialogFooter({
    super.key,
    required this.children,
    this.gap = 8.0,
    this.reverseOnMobile = true,
  });

  final List<Widget> children;
  final double gap;
  final bool reverseOnMobile;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 640;

    if (isSmallScreen) {
      // Mobile: Column layout, reversed order, full width buttons
      final displayChildren = reverseOnMobile
          ? children.reversed.toList()
          : children;

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: displayChildren
            .expand((child) => [child, SizedBox(height: gap)])
            .toList()
          ..removeLast(), // Remove last spacer
      );
    } else {
      // Desktop: Row layout, right-aligned
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: children
            .expand((child) => [child, SizedBox(width: gap)])
            .toList()
          ..removeLast(), // Remove last spacer
      );
    }
  }
}

/// Alert Dialog Title widget
class AlertDialogTitle extends StatelessWidget {
  const AlertDialogTitle({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: child,
    );
  }
}

/// Alert Dialog Description widget
class AlertDialogDescription extends StatelessWidget {
  const AlertDialogDescription({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Dialog description',
      child: child,
    );
  }
}

/// Alert Dialog Action button (primary action)
class AlertDialogAction extends StatelessWidget {
  const AlertDialogAction({
    super.key,
    required this.onPressed,
    required this.child,
    this.autofocus = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: 'Confirm action',
      child: FilledButton(
        onPressed: onPressed,
        autofocus: autofocus,
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          minimumSize: const Size(64, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: child,
      ),
    );
  }
}

/// Alert Dialog Cancel button (secondary action)
class AlertDialogCancel extends StatelessWidget {
  const AlertDialogCancel({
    super.key,
    required this.onPressed,
    required this.child,
    this.autofocus = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: 'Cancel action',
      child: OutlinedButton(
        onPressed: onPressed,
        autofocus: autofocus,
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          minimumSize: const Size(64, 40),
          side: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: child,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// EXAMPLE USAGE
// ═══════════════════════════════════════════════════════════════════════════

/// Example: Basic Alert Dialog
///
/// ```dart
/// FlutterAlertDialog(
///   trigger: ElevatedButton(
///     onPressed: () {},
///     child: const Text('Show Alert'),
///   ),
///   content: AlertDialogContent(
///     title: const AlertDialogTitle(
///       child: Text('Are you absolutely sure?'),
///     ),
///     description: const AlertDialogDescription(
///       child: Text(
///         'This action cannot be undone. This will permanently delete your '
///         'account and remove your data from our servers.',
///       ),
///     ),
///     actions: Builder(
///       builder: (context) => AlertDialogFooter(
///         children: [
///           AlertDialogCancel(
///             onPressed: () => Navigator.of(context).pop(),
///             child: const Text('Cancel'),
///           ),
///           AlertDialogAction(
///             onPressed: () {
///               // Perform action
///               Navigator.of(context).pop();
///             },
///             child: const Text('Continue'),
///           ),
///         ],
///       ),
///     ),
///   ),
/// )
/// ```
