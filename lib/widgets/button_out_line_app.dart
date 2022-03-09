import 'package:arab_shooter_admin/config/config.dart';
import 'package:arab_shooter_admin/widgets/text_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonOutLineApp extends StatelessWidget {
  late String text;
  late FontWeight fontWeight;
  late double fontSize;
  late TextAlign textAlign;
  late double height;
  late Color fontColor;
  late Color? primaryColor;
  late Color outLineColor;
  Icon? iconSelect;
  late void onClick;

  ButtonOutLineApp(
      {required this.text,
      this.fontWeight = FontWeight.normal,
      required this.fontSize,
      this.textAlign = TextAlign.center,
      this.onClick,
      this.primaryColor,
      required this.outLineColor,
      this.iconSelect,
      this.height = 1,
      required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        minimumSize: const Size(0, 50),
        elevation: 10.sp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: outLineColor, width: 2),
        ),
      ),
      onPressed: () { onClick; },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextApp(
              text: text,
              fontColor: fontColor,
              fontSize: fontSize,
            ),
            Center(child: iconSelect),
          ],
        ),
      ),
    );
  }
}
