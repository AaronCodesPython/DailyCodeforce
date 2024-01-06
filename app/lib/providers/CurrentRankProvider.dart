import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../data/Ranks.dart';

class CurrentRank with ChangeNotifier {
  int _rank = 0;
  int get rank => _rank;

  CurrentRank() {
    _initializeRank();
  }

  Future<void> _initializeRank() async {
    if (kIsWeb) {
      final LocalStorage storage = LocalStorage('data.json');
      await storage.ready;
      print("get:${storage.getItem('rank')}");
      _rank = storage.getItem('rank') ?? 0;
    } else {
      final prefs = await SharedPreferences.getInstance();
      _rank = prefs.getInt('rank') ?? 0;
    }
    notifyListeners(); // Notify listeners after updating the rank
  }

  void setRank(int newRank) async {
    if (kIsWeb) {
      final LocalStorage storage = LocalStorage('data.json');
      await storage.ready;
      storage.setItem('rank', newRank);
      print("Set");
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('rank', newRank);
    }
    _rank = newRank;
    notifyListeners();
  }
}
