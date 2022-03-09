import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin HelpersFlushbar {
  void showFlushbar({
    required BuildContext context,
    required String title,
    required String body,
    required Icon iconNotify,
    required Duration time,
    Icon? mainIcon,
    dynamic onClick,
     bool error = false,
  }) {
    Flushbar(
      title: title,
      message: body,
      icon: iconNotify,
      backgroundColor: error ? Colors.redAccent : Colors.blueAccent,
      borderRadius: BorderRadius.circular(25.sp),
      shouldIconPulse: true,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderWidth: 3.sp,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      onTap: (f) => onClick,
      borderColor: Colors.white,
      forwardAnimationCurve: Curves.bounceIn,

      duration: time,
      margin: EdgeInsets.symmetric(horizontal: 16.sp),
    ).show(context);
  }
}
