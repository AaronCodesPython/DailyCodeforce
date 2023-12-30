import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

List<List<dynamic>> ranks = [
  [999, 'Newbie', Colors.grey, Colors.green[800]],
  [1199, 'Pupil', Colors.green[800], Colors.green[200]],
  [1399, 'Apprentice', Colors.green[200], Colors.lightBlue[200]],
  [1599, 'Specialist', Colors.lightBlue[200], Colors.lightBlue[900]],
  [1799, 'Expert', Colors.lightBlue[900], Colors.purple[400]],
  [1999, 'Candidate Master', Colors.purple[400], Colors.orange[400]],
  [2199, 'Master', Colors.orange[400], Colors.orange[600]],
  [2399, 'International Master', Colors.orange[600], Colors.red[700]],
  [2699, 'Grandmaster', Colors.red[700], Colors.red[900]],
  [2999, 'International Grandmaster', Colors.red[900], Colors.purple[600]],
  [3500, 'Legendary Grandmaster', Colors.red[900], Colors.white]
];

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

  int getIndexByRanking() {
    for (int i = 0; i < ranks.length; i++) {
      if (rank <= ranks[i][0]) {
        return i;
      }
    }
    // If rank is greater than the last threshold, return the last index
    return ranks.length - 1;
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
