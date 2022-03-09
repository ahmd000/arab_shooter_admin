import 'dart:async';

import 'package:arab_shooter_admin/config/config.dart';
import 'package:arab_shooter_admin/helpers/dialog_helper.dart';
import 'package:arab_shooter_admin/helpers/helpers.dart';
import 'package:arab_shooter_admin/widgets/button_app.dart';
import 'package:arab_shooter_admin/widgets/button_out_line_app.dart';
import 'package:arab_shooter_admin/widgets/drawer.dart';
import 'package:arab_shooter_admin/widgets/text_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BestClientPageWebView extends StatefulWidget {
  const BestClientPageWebView({Key? key}) : super(key: key);

  @override
  _BestClientPageWebViewState createState() => _BestClientPageWebViewState();
}

class _BestClientPageWebViewState extends State<BestClientPageWebView>
    with showDialogHelper, Helpers {
  late TextEditingController _orderNumbersController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderNumbersController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _orderNumbersController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: ArabShooter().backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () => Get.offAllNamed('/web_view_screen'),

              //
              // Navigator.pushNamedAndRemoveUntil(
              //               context, "/web_view_screen", (route) => false),
              icon: const Icon(Icons.home))
        ],
        elevation: 0,
      ),
      //  drawer: const DrawerWebView(),
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
            Image.asset(ArabShooter().logo2),
            TextApp(
              text: "نحن سعداء للغاية لانك هنا",
              fontSize: 20.sp,
              fontColor: Colors.white,
            ),
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
                  Container(
                    height: 150.h,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image.asset(ArabShooter().soso),
                        Positioned(
                            child: Image.asset(
                          ArabShooter().gift,
                          width: 230.sp,
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Card(
                    elevation: 10.sp,
                    color: Colors.transparent,
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: ArabShooter().buttonColor,
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      child: TextApp(
                        text: 'العميل المميز',
                        textAlign: TextAlign.center,
                        fontColor: Colors.white,
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.sp),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextApp(
                      text:
                          """هي خدمة أطلقتها مجموعة عرب شوتر لتحصيل ثلاث ارقام ناجحة لتحصل فوراً على كود خصم مميز لجميع المنتجات """,
                      fontSize: 20.sp,
                      fontColor: const Color(0xff142249)),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //   launchEmailURL() ;
                      _launchEmailURL();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size(0, 50),
                      elevation: 10.sp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            color: ArabShooter().buttonColor, width: 2),
                      ),
                    ),
                    child: Center(
                      child: TextApp(
                        textAlign: TextAlign.center,
                        text: "ارسل ارقام الطلب",
                        fontColor: ArabShooter().buttonColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextApp(
                    text: 'احصل على هديتك عند ادخال اخر ثلاث ارقام ناجحة',
                    fontSize: 13.sp,
                    fontColor: const Color(0xffA7A7A7),
                  ),
                  SizedBox(
                    height: 40.h,
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

  String sendNumbers = "إرسال ٣ ارقام للطلب ";
  void _launchEmailURL() async {
    showAlertDialog(
        context: context,
        title: "إرسال ٣ ارقام للطلب ",
        content: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                children: [
                  TextField(
                    controller: _orderNumbersController,
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
                onPressed: () async => {
                      if (_orderNumbersController.text.isNotEmpty)
                        {
                          await launch(
                              "mailto:${ArabShooter().emailAppLauncher}?subject=$sendNumbers&body=${_orderNumbersController.text}")
                        }
                      else
                        {
                          showSnackBar(
                              context: context,
                              message: "يرجي ملئ الحقول ",
                              error: true)
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
