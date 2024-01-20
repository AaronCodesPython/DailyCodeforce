import 'package:app/providers/ApiKeyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/Colors.dart' as UsedColors;
class SettingsWidet extends StatelessWidget {
  const SettingsWidet({super.key});

  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onSelected: (String newValue) {
              context.read<ApiKeyProvider>().deleteKeyData();
            },
            itemBuilder: (BuildContext context) {

                return [PopupMenuItem<String>(
                  value: 'Delete API-Key',
                  child: Container(
                    color: const Color.fromRGBO(11, 16, 24, 1),
                    child: const ListTile(
                      title: Text('Delete API-Key',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                )];
             
            });
  }
}

