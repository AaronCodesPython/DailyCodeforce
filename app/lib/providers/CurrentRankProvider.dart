import 'package:flutter/material.dart';

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
  int _index = 0;
  int get index => _index;

  void changeIndex(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }
}
