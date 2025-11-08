import 'package:flutter/material.dart';
import '../ui/alert_dialog.dart';

/// Alert Dialog Demo
///
/// This demo showcases the basic usage of the FlutterAlertDialog component
/// matching the shadcn/ui alert-dialog-demo example.
class AlertDialogDemo extends StatelessWidget {
  const AlertDialogDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterAlertDialog(
        trigger: OutlinedButton(
          onPressed: () {},
          child: const Text('Show Dialog'),
        ),
        content: AlertDialogContent(
          title: const AlertDialogTitle(
            child: Text('Are you absolutely sure?'),
          ),
          description: const AlertDialogDescription(
            child: Text(
              'This action cannot be undone. This will permanently delete your '
              'account and remove your data from our servers.',
            ),
          ),
          actions: Builder(
            builder: (context) => AlertDialogFooter(
              children: [
                AlertDialogCancel(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                AlertDialogAction(
                  onPressed: () {
                    // Perform the action
                    Navigator.of(context).pop();

                    // Show a snackbar to confirm the action
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Action confirmed'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Full page demo with multiple examples
class AlertDialogDemoPage extends StatelessWidget {
  const AlertDialogDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Dialog Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Example
            _buildSection(
              context,
              title: 'Basic Alert Dialog',
              description: 'Standard alert dialog with cancel and continue buttons.',
              child: const AlertDialogDemo(),
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // Destructive Action
            _buildSection(
              context,
              title: 'Destructive Action',
              description: 'Alert dialog for destructive actions like deletion.',
              child: Center(
                child: FlutterAlertDialog(
                  trigger: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete Account'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  content: AlertDialogContent(
                    title: const AlertDialogTitle(
                      child: Text('Delete Account'),
                    ),
                    description: const AlertDialogDescription(
                      child: Text(
                        'Are you sure you want to delete your account? '
                        'This action cannot be undone and all your data will be permanently removed.',
                      ),
                    ),
                    actions: Builder(
                      builder: (context) => AlertDialogFooter(
                        children: [
                          AlertDialogCancel(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // Non-dismissible
            _buildSection(
              context,
              title: 'Non-Dismissible Dialog',
              description: 'Dialog that cannot be dismissed by tapping outside.',
              child: Center(
                child: FlutterAlertDialog(
                  barrierDismissible: false,
                  trigger: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.warning),
                    label: const Text('Show Warning'),
                  ),
                  content: AlertDialogContent(
                    title: const AlertDialogTitle(
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber, color: Colors.orange),
                          SizedBox(width: 8),
                          Text('Important Warning'),
                        ],
                      ),
                    ),
                    description: const AlertDialogDescription(
                      child: Text(
                        'You must acknowledge this warning to continue. '
                        'Tapping outside will not dismiss this dialog.',
                      ),
                    ),
                    actions: Builder(
                      builder: (context) => AlertDialogFooter(
                        children: [
                          AlertDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('I Understand'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // Custom Content
            _buildSection(
              context,
              title: 'Custom Content',
              description: 'Dialog with custom content and layout.',
              child: Center(
                child: FlutterAlertDialog(
                  trigger: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Profile'),
                  ),
                  content: AlertDialogContent(
                    maxWidth: 450,
                    children: [
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Make changes to your profile here.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Builder(
                        builder: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            const SizedBox(width: 8),
                            FilledButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Profile updated'),
                                  ),
                                );
                              },
                              child: const Text('Save Changes'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

/// Example App demonstrating the Alert Dialog component
void main() {
  runApp(const AlertDialogDemoApp());
}

class AlertDialogDemoApp extends StatelessWidget {
  const AlertDialogDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert Dialog Demo',
      debugShowCheckedModeBanner: false,
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
      home: const AlertDialogDemoPage(),
    );
  }
}
