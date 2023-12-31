import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ProblemProvider with ChangeNotifier {
  String? _title;
  int? _contestId;
  int? _rating;

  String? get title => _title;
  int? get contestId => _contestId;
  int? get rating => _rating;

  void setData(String newTitle, int newId, int newRating) {
    _title = newTitle;
    _contestId = newId;
    _rating = newRating;
    notifyListeners();
  }
}
