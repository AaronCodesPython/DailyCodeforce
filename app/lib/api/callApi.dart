import 'dart:convert';
import 'dart:math';

import 'package:app/providers/ApiKeyProvider.dart';
import 'package:app/providers/ProblemProvider.dart';
import 'package:app/widgets/AlertDialog_API.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/CurrentRankProvider.dart';
import 'PseudoRandomNumber.dart';

Future<http.Response?> callApi(BuildContext context) async {
  int rating = context.read<CurrentRank>().rank;
  String? apiKey = context.read<ApiKeyProvider>().apiKey;
  String? secret = context.read<ApiKeyProvider>().secret;

  if (apiKey == null) {
    const ApiDialog().showMyDialog(context);
    return null;
  } else {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    String rand = "";
    Random random = Random();
    for (int i = 0; i < 6; i++) {
      rand += characters[random.nextInt(characters.length - 1)];
    }

    String hexPart = sha512Hex(
        "$rand/problemset.problems?apiKey=$apiKey&time=${DateTime.now().millisecondsSinceEpoch ~/ 1000}#$secret");
    Uri ur = Uri(
        scheme: 'https',
        host: 'codeforces.com',
        path: 'api/problemset.problems',
        queryParameters: {
          'apiKey': apiKey,
          'time': '${DateTime.now().millisecondsSinceEpoch ~/ 1000}',
          'apiSig': '$rand$hexPart'
        });
    var resp = await http.get(ur);
    var jsonData = jsonDecode(resp.body);
    var problems = jsonData['result']['problems'] as List;
    int maxRating = getRankingRange(rating);
    var filteredProblems = problems.where((p) {
      return p['rating'] != null &&
          p['rating'] <= maxRating &&
          p['rating'] >= (rating - 300);
    }).toList();
    int index = getNumber(filteredProblems.length);
    context.read<ProblemProvider>().setData(
        filteredProblems[index]['name'],
        filteredProblems[index]['index'],
        filteredProblems[index]['contestId'],
        filteredProblems[index]['rating']);

    return resp;
  }
}
//https://codeforces.com/apiHelp/methods#problemset.problems
//https://codeforces.com/apiHelp
// TODO <uses-permission android:name="android.permission.INTERNET" />

String sha512Hex(String input) {
  var bytes = utf8.encode(input);
  var digest = sha512.convert(bytes);
  return digest.toString();
}
