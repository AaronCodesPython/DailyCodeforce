import 'package:app/providers/ProblemProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class ErrorWidget_api extends StatelessWidget {
  const ErrorWidget_api({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(context.watch<ProblemProvider>().code.toString());
  }
}