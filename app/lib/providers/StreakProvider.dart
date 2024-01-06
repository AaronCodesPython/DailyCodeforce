import 'package:app/api/PseudoRandomNumber.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakProvider with ChangeNotifier {
  int? _streak;
  int? get streak => _streak;
  int? _lastChange;
  int? get lastIncrease => _lastChange;
  Future<int?> initializeStreak() async {
    if (kIsWeb) {
      final LocalStorage storage = LocalStorage('data.json');
      await storage.ready;
      print("get2:${storage.getItem('apiKey')}");
      _streak = storage.getItem('streak');
    } else {
      final prefs = await SharedPreferences.getInstance();
      _streak = prefs.getInt('streak');
      _lastChange = prefs.getInt('lastChange');
    }

    return _streak;
  }

  void setStreak(int newStreak) async {
    if (_lastChange != daysSinceUnix) {
      _streak = newStreak;
      _lastChange = daysSinceUnix;
      if (kIsWeb) {
        final LocalStorage storage = LocalStorage('data.json');
        await storage.ready;
        storage.setItem('streak', newStreak);
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('streak', newStreak);
        await prefs.setInt('lastChange', daysSinceUnix);
      }
      notifyListeners();
    }
  }
}
