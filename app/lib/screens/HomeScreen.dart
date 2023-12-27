import 'package:app/data/Colors.dart' as UsedColors;
import 'package:app/scraper/exec_scraper.dart';
import 'package:app/widgets/StandartAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            Text(
              '09',
              style: TextStyle(fontSize: 64.sp, color: Colors.white),
            ),
            Text(
              'Days',
              style: TextStyle(fontSize: 28.sp, color: Colors.white),
            ),
            TextButton(
                onPressed: () => executeScraper(),
                child: Text("Scrape Data (Test)"))
          ],
        ),
      ),
    );
  }
}
