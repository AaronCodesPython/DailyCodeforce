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
import '../widgets/ProblemWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: StandardAppBar(),
      backgroundColor: UsedColors.backgroundColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.2,
            ),
            const ProblemWidget(),
            /*FutureBuilder(
              builder: (context, snapshot) {
                print(snapshot.data);
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
            ),*/
            context.read<ApiKeyProvider>().apiKey == null
                ? ApiDialog()
                : SizedBox(
                    height: 0,
                    width: 0,
                  ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(UsedColors.containerColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              child: Text(
                "Load todays Problem",
                style: TextStyle(fontSize: 32.sp),
              ),
              onPressed: () => callApi(context),
            )
          ],
        ),
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