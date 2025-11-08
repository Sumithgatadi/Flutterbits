import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const PreviewRouter());
}

/// Routes to different component previews based on URL parameters
class PreviewRouter extends StatelessWidget {
  const PreviewRouter({super.key});

  @override
  Widget build(BuildContext context) {
    // Get URL parameters from the current URI
    String component = 'alert-dialog';
    String themeParam = 'system';

    if (kIsWeb) {
      final uri = Uri.base;
      component = uri.queryParameters['component'] ?? 'alert-dialog';
      themeParam = uri.queryParameters['theme'] ?? 'system';
    }

    // Determine theme mode
    final ThemeMode themeMode;
    switch (themeParam.toLowerCase()) {
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.system;
    }

    // Route to the appropriate component
    Widget componentWidget;
    switch (component) {
      case 'alert-dialog':
        componentWidget = const AlertDialogDemo();
        break;
      default:
        componentWidget = ErrorComponent(component: component);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutterbits Preview',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeMode,
      home: componentWidget,
    );
  }
}

/// Error component for unknown components
class ErrorComponent extends StatelessWidget {
  final String component;

  const ErrorComponent({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Component not found: $component',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ALERT DIALOG COMPONENT
// ═══════════════════════════════════════════════════════════════════════════

class AlertDialogDemo extends StatelessWidget {
  const AlertDialogDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onPressed: () => _showShadcnDialog(context),
          child: const Text('Show Dialog'),
        ),
      ),
    );
  }

  void _showShadcnDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => const ShadcnAlertDialog(),
    );
  }
}

class ShadcnAlertDialog extends StatefulWidget {
  const ShadcnAlertDialog({super.key});

  @override
  State<ShadcnAlertDialog> createState() => _ShadcnAlertDialogState();
}

class _ShadcnAlertDialogState extends State<ShadcnAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleClose() async {
    await _controller.reverse();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 640;
    final maxWidth = isSmallScreen ? mediaQuery.size.width - 32 : 512.0;
    final colorScheme = Theme.of(context).colorScheme;

    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.escape) {
          _handleClose();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
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
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: isSmallScreen
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Are you absolutely sure?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 1.33,
                              color: colorScheme.onSurface,
                            ),
                            textAlign: isSmallScreen
                                ? TextAlign.center
                                : TextAlign.start,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'This action cannot be undone. This will permanently delete your '
                            'account and remove your data from our servers.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            textAlign: isSmallScreen
                                ? TextAlign.center
                                : TextAlign.start,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      if (isSmallScreen)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FilledButton(
                              onPressed: _handleClose,
                              style: FilledButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: colorScheme.onPrimary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                minimumSize: const Size(64, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text('Continue'),
                            ),
                            const SizedBox(height: 8),
                            OutlinedButton(
                              onPressed: _handleClose,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: colorScheme.onSurface,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                minimumSize: const Size(64, 40),
                                side: BorderSide(
                                    color: colorScheme.outline, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text('Cancel'),
                            ),
                          ],
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: _handleClose,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: colorScheme.onSurface,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                minimumSize: const Size(64, 40),
                                side: BorderSide(
                                    color: colorScheme.outline, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text('Cancel'),
                            ),
                            const SizedBox(width: 8),
                            FilledButton(
                              onPressed: _handleClose,
                              style: FilledButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: colorScheme.onPrimary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                minimumSize: const Size(64, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text('Continue'),
                            ),
                          ],
                        ),
                    ],
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
