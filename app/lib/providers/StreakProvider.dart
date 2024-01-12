import 'package:app/api/PseudoRandomNumber.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakProvider with ChangeNotifier {
  int? _streak;
  int? get streak => _streak;
  int? _lastChange;
  int? get lastIncrease => _lastChange;

  Future<int?> initializeStreak() async {
    final prefs = await SharedPreferences.getInstance();
    _streak = prefs.getInt('streak');
    _lastChange = prefs.getInt('lastChange');
    if (_lastChange != null && daysSinceUnix - _lastChange! >= 2) {
      setStreakStd(0);
    }
    return _streak;
  }

  void setStreak(int newStreak) async {
    if (_lastChange != daysSinceUnix) {
      _streak = newStreak;
      _lastChange = daysSinceUnix;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('streak', newStreak);
      await prefs.setInt('lastChange', daysSinceUnix);
      notifyListeners();
    }
  }

  void setStreakStd(int newStreak) async {
    _streak = newStreak;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('streak', newStreak);
    notifyListeners();
  }
}
