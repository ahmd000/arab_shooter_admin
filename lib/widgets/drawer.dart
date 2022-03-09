import 'package:arab_shooter_admin/config/config.dart';
import 'package:arab_shooter_admin/widgets/text_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWebView extends StatefulWidget {
  const DrawerWebView({Key? key}) : super(key: key);

  @override
  _DrawerWebViewState createState() => _DrawerWebViewState();
}

class _DrawerWebViewState extends State<DrawerWebView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 5.sp,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 40.sp,
          ),
          color: ArabShooter().backgroundColor,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.sp,
              vertical: 8.sp,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.sp),
            ),
            child: Column(
              children: [
                Image.asset(ArabShooter().logo),
                SizedBox(
                  height: 25.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.offAllNamed("/web_view_screen");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.sp)),
                      minimumSize: const Size(0, 50),
                      primary: Colors.white,
                      elevation: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        size: 30.w,
                        color: ArabShooter().backgroundColor,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      TextApp(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        text: "الرئيسية",
                        textAlign: TextAlign.start,
                        fontColor: ArabShooter().backgroundColor,
                      ),
                    ],
                  ),
                  //

                  // label:
                ),
                SizedBox(
                  height: 15.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed("/best_client");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.sp)),
                      minimumSize: const Size(0, 50),
                      primary: Colors.white,
                      elevation: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        size: 30.w,
                        color: ArabShooter().backgroundColor,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      TextApp(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        text: "العميل المميز",
                        textAlign: TextAlign.start,
                        fontColor: ArabShooter().backgroundColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed("/support");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.sp)),
                      minimumSize: const Size(0, 50),
                      primary: Colors.white,
                      elevation: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.question_answer,
                        size: 30.w,
                        color: ArabShooter().backgroundColor,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      TextApp(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        text: "الدعم والمساعدة",
                        textAlign: TextAlign.start,
                        fontColor: ArabShooter().backgroundColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed("/notification_screen");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.sp)),
                      minimumSize: const Size(0, 50),
                      primary: Colors.white,
                      elevation: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 30.w,
                        color: ArabShooter().backgroundColor,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      TextApp(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        text: "إرسال إشعار",
                        textAlign: TextAlign.start,
                        fontColor: ArabShooter().backgroundColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed("/list_notification_screen");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.sp)),
                      minimumSize: const Size(0, 50),
                      primary: Colors.white,
                      elevation: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.format_list_numbered_outlined,
                        size: 30.w,
                        color: ArabShooter().backgroundColor,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      TextApp(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        text: "قائمة الاشعارات",
                        textAlign: TextAlign.start,
                        fontColor: ArabShooter().backgroundColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),

                Divider(
                  color: Colors.black38,
                  height: 10.sp,
                ),
                SizedBox(
                  height: 15.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    _launchURL();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.sp)),
                      minimumSize: const Size(0, 50),
                      primary: Colors.white,
                      elevation: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ArabShooter().whatsIcon,
                        width: 40.w,
                        height: 40.w,
                        fit: BoxFit.contain,
                        color: ArabShooter().backgroundColor,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      TextApp(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        text: "تواصل معنا ",
                        textAlign: TextAlign.start,
                        fontColor: ArabShooter().backgroundColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL() async => await launch(ArabShooter().whatsAppLauncher);
}
