import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:app/data/Colors.dart' as UsedColors;
import 'package:app/providers/StreakProvider.dart';
import 'package:app/widgets/RankingWidget.dart';
import 'package:app/widgets/CountdownTimer.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  StandardAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AppBar(
      toolbarHeight: kToolbarHeight,
      backgroundColor: const Color.fromRGBO(11, 16, 24, 1),
      leading: Container(
        margin: const EdgeInsets.all(8),
        color: UsedColors.containerColor,
        child: const Center(child: CountdownTimer()),
      ),
      leadingWidth: screenWidth * 0.3 > 300 ? 300 : screenWidth * 0.3,
      title: Center(
        child: FutureBuilder(
          future: context.read<StreakProvider>().initializeStreak(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (context.read<StreakProvider>().streak == null) {
                context.read<StreakProvider>().setStreakStd(0);
              }
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.watch<StreakProvider>().streak.toString(),
                    style: TextStyle(fontSize: 32.sp, color: Colors.white),
                  ),
                  Text(
                    ' Days Streak',
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      actions: [
        RankingWidget(),
        Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                color: UsedColors.containerColor, shape: BoxShape.circle),
            child: PopupMenuButton(
              color: UsedColors.containerColor,
              icon: const Icon(
                Icons.settings,
                color: UsedColors.iconColor,
              ),
              onSelected: (String res) {},
              itemBuilder: (context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'reload',
                    child: Row(
                      children: const [
                        Icon(Icons.repeat),
                        Text('Reload App'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'time',
                    child: Text('Time Format Setting'),
                  ),
                  // Add more items here
                ];
              },
            )),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: UsedColors.bottomBorderColor,
          height: 1.0,
        ),
      ),
    );
  }
}
