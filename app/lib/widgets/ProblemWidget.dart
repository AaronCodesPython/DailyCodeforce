import 'package:app/providers/ProblemProvider.dart';
import 'package:app/providers/StreakProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool show = context.watch<ProblemProvider>().code != null;
    String comment = context.watch<ProblemProvider>().comment!;
    String url =
        'https://codeforces.com/problemset/problem/${context.watch<ProblemProvider>().contestId}/${context.watch<ProblemProvider>().index}';
    return show ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: context.watch<ProblemProvider>().code == 200?[
        context.watch<ProblemProvider>().title != null
            ? Text(
                context.watch<ProblemProvider>().title!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 64.sp),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        const SizedBox(
          height: 50,
        ),
        context.watch<ProblemProvider>().rating != null
            ? Text(
                'Rating:${context.watch<ProblemProvider>().rating.toString()}',
                style: TextStyle(color: Colors.white, fontSize: 32.sp),
                textAlign: TextAlign.center,
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        show
            ? Text(
                'Contest-Id:${context.watch<ProblemProvider>().contestId.toString()}',
                style: TextStyle(color: Colors.white, fontSize: 32.sp),
                textAlign: TextAlign.center)
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        Center(
          child: show
              ? InkWell(
                  child: Text(
                    url,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 26.sp),
                  ),
                  onTap: () => launchUrl(Uri.parse(url)),
                )
              : const SizedBox(height: 0, width: 0),
        ),
        const SizedBox(height: 40),
        show
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(49, 130, 20, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 10,
                      vertical: 20.sp),
                ),
                onPressed: () {
                  context
                      .read<StreakProvider>()
                      .setStreak(context.read<StreakProvider>().streak! + 1);
                  Navigator.pushReplacementNamed(context, '/congratulation');
                },
                child: Text(
                  'Mark as Done',
                  style: TextStyle(fontSize: 22.sp, color: Colors.white),
                ),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              )
      ]:[
        Text(comment, style: TextStyle(color: Colors.white),)
      ],
    ): CircularProgressIndicator();
  }
}
