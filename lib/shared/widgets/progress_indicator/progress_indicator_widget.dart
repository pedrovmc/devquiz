import 'package:flutter/material.dart';

import 'package:DevQuiz/core/app_colors.dart';

class ProgressIndicatorWidget extends StatefulWidget {
  final double value;
  const ProgressIndicatorWidget({
    Key? key,
    required this.value,
  }) : super(key: key);
  @override
  _ProgressIndicatorWidgetState createState() =>
      _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: 0.3,
      backgroundColor: AppColors.chartSecondary,
      valueColor: AlwaysStoppedAnimation<Color>(
        AppColors.chartPrimary,
      ),
    );
  }
}
