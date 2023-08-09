import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback onPressed;

  final bool isAllFieldsValid;

  const CustomeButton(
      {super.key,
      this.child,
      required this.onPressed,
      required this.isAllFieldsValid});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: isAllFieldsValid ? Colors.green : Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
