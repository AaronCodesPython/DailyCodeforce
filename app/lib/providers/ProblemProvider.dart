import 'package:flutter/foundation.dart';

class ProblemProvider with ChangeNotifier {
  int? _code;
  String? _title;
  String? _index;
  String? _comment;
  int? _contestId;
  int? _rating;
  bool apiCalled = false;

  int? get code => _code;
  String? get title => _title;
  String? get index => _index;
  String? get comment => _comment;
  int? get contestId => _contestId;
  int? get rating => _rating;

  void setData(int newCode, String? newTitle, String? newIndex, int? newId, int? newRating, String newComment) {
    _code = newCode;
    _title = newTitle;
    _index = newIndex;
    _contestId = newId;
    _rating = newRating;
    _comment = newComment;
    notifyListeners();
  }
}
