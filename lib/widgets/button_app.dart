import 'package:arab_shooter_admin/config/config.dart';
import 'package:arab_shooter_admin/widgets/text_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonApp extends StatelessWidget {
  late String text;
  late FontWeight fontWeight;
  late double fontSize;
  late TextAlign textAlign;
  late double height;
  late Color fontColor;
   Icon? iconSelect;
  late void onClick;

  ButtonApp(
      {required this.text,
      this.fontWeight = FontWeight.normal,
      required this.fontSize,
      this.textAlign = TextAlign.center,
      this.onClick,
       this.iconSelect,
      this.height = 1,
      required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      style: ElevatedButton.styleFrom(
          primary: ArabShooter().buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(child: iconSelect),
          SizedBox(width: 30.w,) ,
          TextApp(
            text: text,
            fontColor: fontColor,
            fontSize: fontSize,
          )
        ],
      ),
    );
  }
}
