import 'package:app/providers/StreakProvider.dart';
import 'package:app/widgets/CountdownTimer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/PseudoRandomNumber.dart';
import '../data/Colors.dart' as UsedColors;

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle s = TextStyle(color: Colors.white, fontSize: 32.sp);

    return Scaffold(
      backgroundColor: UsedColors.backgroundColor,
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          Text('Congratulations, you have finished todays problem...',
              style: s),
          FutureBuilder(
              future: context.read<StreakProvider>().initializeStreak(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (context.read<StreakProvider>().streak == null) {
                    context.read<StreakProvider>().setStreakStd(0);
                  }
                  return RichText(
                    text: TextSpan(
                      text: "You now have a ",
                      style: s,
                      children: <TextSpan>[
                        TextSpan(
                            text: snapshot.data.toString(),
                            style:
                                TextStyle(color: Colors.green, fontSize: 32.sp),
                            children: [
                              TextSpan(text: ' Days Streak!', style: s)
                            ]),
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
          Text(
            '',
            style: s,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          Text('New problem in: ',
              style: TextStyle(color: Colors.white, fontSize: 18.sp)),
          const CountdownTimer(),
          TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                var g = <String, String>{
                  for (String key in prefs.getKeys()) ...{
                    key: prefs.get(key).toString()
                  }
                };
                print(g.toString());
                print(
                    "unix: ${DateTime.now().millisecondsSinceEpoch / 86400000}");
                print("unix-days: ${daysSinceUnix}");
                print("unix-Milli:${DateTime.now().millisecondsSinceEpoch}");
                //prefs.clear();
              },
              child: Text("dqwfafaf"))
        ]),
      ),
    );
  }
}
