import 'package:app/providers/ApiKeyProvider.dart';
import 'package:app/providers/CurrentRankProvider.dart';
import 'package:app/providers/ProblemProvider.dart';
import 'package:app/providers/StreakProvider.dart';
import 'package:app/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'api/PseudoRandomNumber.dart';
import 'screens/CongratulationScreen.dart';

void main(List<String> args) async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CurrentRank()),
      ChangeNotifierProvider(create: (_) => ApiKeyProvider()),
      ChangeNotifierProvider(create: (_) => StreakProvider()),
      ChangeNotifierProvider(create: (_) => ProblemProvider())
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final streakProvider = Provider.of<StreakProvider>(context, listen: false);

    return FutureBuilder(
        future: streakProvider.initializeStreak(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ScreenUtilInit(
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  initialRoute: streakProvider.lastIncrease != daysSinceUnix
                      ? '/'
                      : '/congratulation',
                  routes: {
                    '/': (context) => const HomeScreen(),
                    '/congratulation': (context) => const CongratulationScreen()
                  },
                  theme: ThemeData(
                    popupMenuTheme: const PopupMenuThemeData(
                      color: Colors.transparent, // Set to transparent
                      // You can also add other styling properties if needed
                    ),
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
// TODO: add warning that it may be slow during contests
// add loading indicator, and a error code if reqeust fails
