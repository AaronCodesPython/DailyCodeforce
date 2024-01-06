import 'dart:math';
import 'package:app/providers/CurrentRankProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/Ranks.dart';

int daysSinceUnix = (DateTime.now().millisecondsSinceEpoch / 86400000).floor();
int getNumber(int max) {
  Random random = Random(daysSinceUnix);
  int r = random.nextInt(max);
  return r;
}

int getRankingRange(int rank) {
  // 80 % change of getting problem in your range, 20 % chance of getting higher rated problem (upto 200 higher)
  int curRankIndex = getIndexByRanking(rank);
  int maxRank;

  int v = Random(daysSinceUnix).nextInt(9) + 1;
  if (v <= 8) {
    maxRank = ranks[curRankIndex][0];
  } else {
    maxRank =
        ranks[curRankIndex + 1 <= 10 ? curRankIndex + 1 : curRankIndex][0];
  }
  return maxRank;
}
