import 'package:app/providers/ApiKeyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a text editing controller
    final TextEditingController textController = TextEditingController();

    // Schedule the dialog to show after the current build cycle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter a string:'),
              TextField(
                controller: textController, // Use the text controller here
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Print the text from the controller
                print('Entered text: ${textController.text}');
                context.read<ApiKeyProvider>().setApiKey(textController.text);
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });

    // Return an empty Container as the widget does not need to display anything itself
    return Container();
  }
}
