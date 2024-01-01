import 'package:app/providers/ProblemProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.watch<ProblemProvider>().title != null
            ? Text(
                context.watch<ProblemProvider>().title!,
                style: TextStyle(color: Colors.white, fontSize: 64.sp),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        context.watch<ProblemProvider>().rating != null
            ? Text(
                context.watch<ProblemProvider>().rating.toString(),
                style: TextStyle(color: Colors.white, fontSize: 32.sp),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        context.watch<ProblemProvider>().contestId != null
            ? Text(
                context.watch<ProblemProvider>().contestId.toString(),
                style: const TextStyle(color: Colors.white),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
      ],
    );
  }
}
