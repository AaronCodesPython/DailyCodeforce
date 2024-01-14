import 'dart:io';

import 'package:app/api/callApi.dart';
import 'package:app/data/Colors.dart' as UsedColors;
import 'package:app/providers/ProblemProvider.dart';
import 'package:app/widgets/AlertDialog_API.dart';
import 'package:app/widgets/ErrorWidget.dart';
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
              height: Platform.isIOS || Platform.isAndroid
                  ? height * 0.1
                  : height * 0.2,
            ),
            context.read<ProblemProvider>().code != 200 ? 
            const ErrorWidget_api():
            const ProblemWidget(),
            context.read<ApiKeyProvider>().apiKey == null
                ? const ApiDialog()
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
            context.watch<ProblemProvider>().title == null
                ? TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            UsedColors.containerColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "Load todays Problem",
                      style: TextStyle(fontSize: 32.sp),
                    ),
                    onPressed: () {
                      callApi(context);
                    },
                  )
                : const SizedBox(height: 0, width: 0)
          ],
        ),
      ),
    );
  }
}
