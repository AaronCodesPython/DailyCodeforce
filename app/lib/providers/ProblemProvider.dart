import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ProblemProvider with ChangeNotifier {
  String? _title;
  String? _index;
  int? _contestId;
  int? _rating;

  String? get title => _title;
  String? get index => _index;
  int? get contestId => _contestId;
  int? get rating => _rating;

  void setData(String newTitle, String newIndex, int newId, int newRating) {
    _title = newTitle;
    _index = newIndex;
    _contestId = newId;
    _rating = newRating;
    notifyListeners();
  }
}
