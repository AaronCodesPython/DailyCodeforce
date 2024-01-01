import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyProvider with ChangeNotifier {
  String? _apiKey;
  String? get apiKey => _apiKey;

  Future<String?> _initializeApiKey() async {
    if (kIsWeb) {
      final LocalStorage storage = LocalStorage('data.json');
      await storage.ready;
      print("get2:${storage.getItem('apiKey')}");
      _apiKey = storage.getItem('apiKey');
    } else {
      final prefs = await SharedPreferences.getInstance();
      _apiKey = prefs.getString('apiKey');
    }
    notifyListeners();
    return _apiKey;
  }

  void setApiKey(String newApikey) async {
    _apiKey = newApikey;
    if (kIsWeb) {
      final LocalStorage storage = LocalStorage('data.json');
      await storage.ready;
      storage.setItem('apiKey', newApikey);
      print("Set");
    } else {
      print("newApikey:$newApikey");
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('apiKey', newApikey);
      print("Set");
    }
    notifyListeners();
  }
}
