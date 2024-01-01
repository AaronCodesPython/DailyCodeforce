import 'package:app/api/callApi.dart';
import 'package:app/providers/ApiKeyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/Colors.dart' as UsedColors;

class ApiDialog extends StatelessWidget {
  const ApiDialog({super.key});

  void showMyDialog(BuildContext HigherContext) {
    final TextEditingController textController1 = TextEditingController();
    final TextEditingController textController2 = TextEditingController();
    showDialog<String>(
      context: HigherContext,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: UsedColors.backgroundColor,
        title: const Center(
            child: Text(
          'Please Input your Api-Key:',
          style: TextStyle(color: Colors.white),
        )),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController1,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                fillColor: Colors.white,
                hintText: 'Api-Key',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white), // Change to desired color
                ),
              ),
            ),
            TextField(
              controller: textController2,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Secret',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white), // Change to desired color
                ),
              ),
            ),
            const Text(
              'Generating and using an Api-Key is free, you can do so at https://codeforces.com/settings/api',
              style: TextStyle(color: Colors.white),
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
              print('Entered text: ${textController1.text}');
              context.read<ApiKeyProvider>().setApiKey(textController1.text);
              // Perform your action with the text here
              callApi(HigherContext);
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
