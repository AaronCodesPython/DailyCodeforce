import 'package:app/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RankingWidget extends StatelessWidget {
  int ranking;
  RankingWidget({required this.ranking, super.key});
  List<Color> getColorsByRank(int rank) {
    if (rank <= 1200) {
      return [Colors.green, Colors.deepOrange];
    } else {
      return [];
    }
  }

  String getRankString(int rank) {
    return 'Newbie';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MyCustomDropdown();
  }
}
