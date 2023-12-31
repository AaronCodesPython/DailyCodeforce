import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app/providers/ApiKeyProvider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/CurrentRankProvider.dart';

Future<http.Response> callApi(BuildContext context) async {
  var logFile = File('logFile.log').openWrite(mode: FileMode.append);
  int currentRating = context.read<CurrentRank>().rank;
  String apiKey = context.read<ApiKeyProvider>().apiKey!;
  const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  String rand = "";
  Random random = Random();
  for (int i = 0; i < 6; i++) {
    rand += characters[random.nextInt(characters.length - 1)];
  }
  print(
      "$rand/problemset.problems?apiKey=a8dd9471aa84876ec39a6bc91ec0c0317c5957f9&time=${DateTime.now().millisecondsSinceEpoch ~/ 1000}#3e54bb7ff326b9eb6854f2d6f3f54688fc3e22d1");
  String hexPart = sha512Hex(
      "$rand/problemset.problems?apiKey=a8dd9471aa84876ec39a6bc91ec0c0317c5957f9&time=${DateTime.now().millisecondsSinceEpoch ~/ 1000}#3e54bb7ff326b9eb6854f2d6f3f54688fc3e22d1");
  Uri ur = Uri(
      scheme: 'https',
      host: 'codeforces.com',
      path: 'api/problemset.problems',
      queryParameters: {
        'apiKey': 'a8dd9471aa84876ec39a6bc91ec0c0317c5957f9',
        'time': '${DateTime.now().millisecondsSinceEpoch ~/ 1000}',
        'apiSig': '$rand$hexPart'
      });
  var resp = await http.get(ur);
  logFile.write(ur.toString());
  logFile.write(resp.body);
  print(ur.toString());
  print(resp.body);
  return resp;
}
//https://codeforces.com/apiHelp/methods#problemset.problems
//https://codeforces.com/apiHelp
// TODO <uses-permission android:name="android.permission.INTERNET" />

String sha512Hex(String input) {
  var bytes = utf8.encode(input);
  var digest = sha512.convert(bytes);
  print(digest.toString());
  return digest.toString();
}
// TODO remove own apiKey