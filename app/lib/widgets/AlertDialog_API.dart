import 'package:app/providers/ApiKeyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  void showMyDialog(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter a string:'),
            TextField(
              controller: textController,
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
              print('Entered text: ${textController.text}');
              context.read<ApiKeyProvider>().setApiKey(textController.text);
              // Perform your action with the text here
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This widget now does not need to display anything itself
    return Container();
  }
}
