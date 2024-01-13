import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../data/Ranks.dart';
import '../providers/CurrentRankProvider.dart';

class RankingWidget extends StatelessWidget {
  const RankingWidget({super.key});
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
    int startIndex = getIndexByRanking(context.watch<CurrentRank>().rank);

    return FutureBuilder(
      builder: (context, snapshot) {
        return PopupMenuButton<String>(
            child: Container(
              width: screenWidth * 0.3 > 300 ? 300 : screenWidth * 0.3,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [ranks[startIndex][2], ranks[startIndex][3]],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Center(
                child: Text(
                  ranks[startIndex][1],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white, fontSize: 16.sp > 22 ? 22 : 16.sp),
                ),
              ),
            ),
            onSelected: (String newValue) {
              context.read<CurrentRank>().setRank(int.parse(newValue));
            },
            itemBuilder: (BuildContext context) {
              return ranks.map((entry) {
                return PopupMenuItem<String>(
                  value: entry[0].toString(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          entry[2],
                          entry[3]
                        ], // Replace with desired colors or logic
                      ),
                    ),
                    child: ListTile(
                      title: Text(entry[1],
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              }).toList();
            });
      },
    );
  }
}
