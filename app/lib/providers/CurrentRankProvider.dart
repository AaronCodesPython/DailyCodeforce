import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentRank with ChangeNotifier {
  int _rank = 0;
  int get rank => _rank;

  CurrentRank() {
    _initializeRank();
  }

  Future<void> _initializeRank() async {
    final prefs = await SharedPreferences.getInstance();
    _rank = prefs.getInt('rank') ?? 0;
    notifyListeners();
  }

  void setRank(int newRank) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('rank', newRank);
    _rank = newRank;
    notifyListeners();
  }
}
