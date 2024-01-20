import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyProvider with ChangeNotifier {
  String? _apiKey;
  String? get apiKey => _apiKey;
  String? _secret;
  String? get secret => _secret;
  ApiKeyProvider() {
    _initializeApiKey();
  }

  Future<void> _initializeApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    _apiKey = prefs.getString('api');
    _secret = prefs.getString('secret');
    notifyListeners();
  }

  void setApiKey(String newApikey, String newSecret) async {
    _apiKey = newApikey;
    _secret = newSecret;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api', newApikey);
    await prefs.setString('secret', newSecret);
    notifyListeners();
  }

  void deleteKeyData() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('api');
    prefs.remove('secret');
    _apiKey = null;
    _secret = null;
    notifyListeners();
  }
}
