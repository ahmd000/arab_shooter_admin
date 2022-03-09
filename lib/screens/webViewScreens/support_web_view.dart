import 'dart:async';

import 'package:arab_shooter_admin/config/config.dart';
import 'package:arab_shooter_admin/helpers/dialog_helper.dart';
import 'package:arab_shooter_admin/helpers/helpers.dart';
import 'package:arab_shooter_admin/widgets/button_app.dart';
import 'package:arab_shooter_admin/widgets/drawer.dart';
import 'package:arab_shooter_admin/widgets/text_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SupportPageWebView extends StatefulWidget {
  const SupportPageWebView({Key? key}) : super(key: key);

  @override
  _SupportPageWebViewState createState() => _SupportPageWebViewState();
}

class _SupportPageWebViewState extends State<SupportPageWebView>
    with showDialogHelper, Helpers {
  late TextEditingController _objectMessageController;
  late TextEditingController _bodyMessageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _objectMessageController = TextEditingController();
    _bodyMessageController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _objectMessageController.dispose();
    _bodyMessageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: ArabShooter().backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Get.offAllNamed('/web_view_screen'),
              // Navigator.pushNamedAndRemoveUntil(
              //     context, "/web_view_screen", (route) => false),
              icon: const Icon(Icons.home))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const DrawerWebView(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.sp,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100.h,
            ),
            TextApp(
                text: "الدعم والمساعدة",
                fontSize: 30.sp,
                fontColor: Colors.white,),
            TextApp(
                text: "Support and help",
                fontSize: 30.sp,
                fontColor: Colors.white),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.sp),
                  topRight: Radius.circular(50.sp),
                ),
              ),
              child: Column(
                children: [
                  Image.asset(ArabShooter().logo),
                  SizedBox(
                    height: 20.h,
                  ),
                  Image.asset(
                    ArabShooter().supportLogo,
                    height: 180.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Share.share(
                            'يمكنك مشاركة موقعنا مع أصدقائك  ${ArabShooter().homeWebViewPage}');
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10.sp),
                          primary: ArabShooter().buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            size: 25.sp,
                          ),
                          Expanded(
                              child: TextApp(
                            text: 'شارك التطبيق',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.white,
                          ))
                        ],
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _launchEmailURL();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10.sp),
                          primary: ArabShooter().buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_border,
                            size: 25.sp,
                          ),
                          Expanded(
                              child: TextApp(
                            text: 'للإقتراحات والشكاوى',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.white,
                          ))
                        ],
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed("/web_view_screen");
                        launch(ArabShooter().homeWebViewPage);


                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10.sp),
                          primary: ArabShooter().buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 25.sp,
                          ),
                          Expanded(
                              child: TextApp(
                            text: 'زور متجرنا الإلكتروني',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            fontColor: Colors.white,
                          ))
                        ],
                      )),
                  SizedBox(
                    height: 25.h,
                  ),
                  Image.asset(
                    ArabShooter().logo,
                    width: 200.w,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _launchEmailURL() async {
    showAlertDialog(
        context: context,
        title: "إرسال شكوى ",
        content: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                children: [
                  TextField(
                    controller: _objectMessageController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      fontSize: 23.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: "عنوان الرسالة",
                      labelStyle: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 23.sp,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 20.sp,
                      ),
                      prefixIcon: const Icon(Icons.title),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _bodyMessageController,
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.start,
                    minLines: 3,
                    maxLines: 5,
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      fontSize: 23.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: "موضوع الرسالة",
                      labelStyle: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 23.sp,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 20.sp,
                      ),
                      prefixIcon: const Icon(Icons.subtitles),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_bodyMessageController.text.isNotEmpty &&
                      _objectMessageController.text.isNotEmpty) {
                    await launch(
                        "mailto:${ArabShooter().emailAppLauncher}?subject=${_objectMessageController.text}&body=${_bodyMessageController.text}");
                  } else {
                    showSnackBar(
                        context: context,
                        message: "يرجي ملئ الحقول ",
                        error: true);
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10.sp),
                    primary: ArabShooter().backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextApp(
                      text: "إرسال بريد الكتروني",
                      fontSize: 20.sp,
                      fontColor: Colors.white,
                    ),
                    Icon(
                      Icons.send,
                      size: 25.sp,
                    ),
                  ],
                )),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10.sp),
                    primary: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextApp(
                      text: "إلغاء",
                      fontSize: 20.sp,
                      fontColor: Colors.white,
                    ),
                    Icon(
                      Icons.cancel,
                      size: 25.sp,
                    ),
                  ],
                )),
          ],
        ));
  }
}
