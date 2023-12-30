import 'package:app/api/callApi.dart';
import 'package:app/data/Colors.dart' as UsedColors;
import 'package:app/providers/CurrentRankProvider.dart';
import 'package:app/providers/StreakProvider.dart';
import 'package:app/widgets/AlertDialog_API.dart';
import 'package:app/widgets/StandartAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/ApiKeyProvider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: StandardAppBar(),
      backgroundColor: UsedColors.backgroundColor,
      body: Column(
        children: [
          Row(
            children: [
              FutureBuilder(
                future: context.read<StreakProvider>().initializeStreak(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Initialize streak to 0 if it's null
                    if (context.read<StreakProvider>().streak == null) {
                      context.read<StreakProvider>().setStreak(0);
                    }
                    // Display the current streak
                    return Text(
                      context.watch<StreakProvider>().streak.toString(),
                      style: TextStyle(fontSize: 64.sp, color: Colors.white),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              Text(
                'Days',
                style: TextStyle(fontSize: 28.sp, color: Colors.white),
              ),
            ],
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Text(
                      "Api Key is set to: ${context.watch<ApiKeyProvider>().apiKey}");
                } else {
                  return DialogExample();
                }
              } else {
                return CircularProgressIndicator();
              }

              //DialogExample();
            },
            future: context.read<ApiKeyProvider>().initializeApiKey(),
          ),
          TextButton(
            child: Text("Show todays Problem"),
            onPressed: () => callApi(context),
          )
        ],
      ),
    );
  }
}
/*FloatingActionButton(
              onPressed: () {
                int currentStreak = context.read<StreakProvider>().streak ?? 0;
                context.read<StreakProvider>().setStreak(currentStreak + 1);
              },
              backgroundColor: Colors.red,
            )*/