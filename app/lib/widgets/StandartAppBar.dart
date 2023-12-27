import 'package:app/data/Colors.dart' as UsedColors;
import 'package:app/widgets/RankingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CountdownTimer.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  StandardAppBar({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define your colors outside of build method if they are constants

    // Use MediaQuery to determine screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust leadingWidth based on screen width
    return AppBar(
      toolbarHeight: kToolbarHeight,
      backgroundColor: UsedColors.backgroundColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: UsedColors.bottomBorderColor,
          height: 1.0,
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.all(8),
        color: UsedColors.containerColor,
        child: const Center(child: CountdownTimer()),
      ),
      leadingWidth: screenWidth * 0.3 > 300 ? 300 : screenWidth * 0.3,
      actions: [
        RankingWidget(ranking: 200),
        Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: UsedColors.containerColor, shape: BoxShape.circle),
          child: TextButton(
              onPressed: () {},
              child: Text("AG",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20.sp > 25 ? 25 : 20.sp))),
        )
      ],
    );
  }
}
