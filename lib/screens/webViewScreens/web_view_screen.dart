import 'dart:io';

import 'package:arab_shooter_admin/config/config.dart';
import 'package:arab_shooter_admin/helpers/dialog_helper.dart';
import 'package:arab_shooter_admin/helpers/helpers.dart';
import 'package:arab_shooter_admin/widgets/button_app.dart';
import 'package:arab_shooter_admin/widgets/drawer.dart';
import 'package:arab_shooter_admin/widgets/text_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../helpers/flushbar_heper.dart';
import '../../notification_controller/fb_notifications.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen>
    with FbNotifications, Helpers, HelpersFlushbar, showDialogHelper {
  late WebViewController controller;
  DateTime timeBackPressed = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    getToken();
    forgroundFirebaseMessaging();
    onMessageController();
    requestPermissionIOS();
    subscribeGeneralTopic();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final differences = DateTime.now().difference(timeBackPressed);
        final isExitWarning = differences >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          }

          const msg = "يرجي الضغط مرة اخري للخروج من التطبيق !";
          print(msg);
          showSnackBar(context: context, message: msg, error: false);
          return false;
        } else {
          print("مع السلامة ");
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 5.sp,
          backgroundColor: ArabShooter().backgroundColor,
          centerTitle: true,
          title: TextApp(
            text: "الرئيسية",
            fontColor: Colors.white,
            fontSize: 25.sp,
          ),
          actions: [
            IconButton(
              onPressed: () => controller.reload(),
              icon: const Icon(Icons.home),
            ),
          ],
        ),
        drawer: const DrawerWebView(),
        body: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: ArabShooter().homeWebViewPage,
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
            zoomEnabled: true,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
            allowsInlineMediaPlayback: true,
            debuggingEnabled: false,
            gestureNavigationEnabled: true,
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith("https://wa.me/")) {
                print(request.url);
                launch(request.url);
                return NavigationDecision.prevent;
              } else  if(request.url.startsWith("https://t.me/")){
                launch(request.url);
                return NavigationDecision.prevent;
              }else{
                return NavigationDecision.navigate ;
              }
            }
            // },
            ),
      ),
    );
  }

  getToken() async {
    await ArabShooter().firebaseMessaging.getToken().then((token) {
      print("Token: $token");
    });
  }

  requestPermissionIOS() async {
    NotificationSettings settings =
        await ArabShooter().firebaseMessaging.requestPermission(
              alert: true,
              announcement: false,
              badge: true,
              carPlay: false,
              criticalAlert: false,
              provisional: false,
              sound: true,
            );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  onMessageController() async {
    await FirebaseMessaging.onMessageOpenedApp.listen((message) {
      showDialogNotify(message);
    });

    var message = await ArabShooter().firebaseMessaging.getInitialMessage();
    if (message != null) {
      showDialogNotify(message);
    }
  }

  void showDialogNotify(RemoteMessage message) {
    showAlertDialog(
      context: context,
      title: "${message.notification!.title}",
      content: Column(
        children: [
          TextApp(
            text: "${message.notification!.body}",
            textAlign: TextAlign.start,
            fontSize: 20.sp,
            fontColor: ArabShooter().backgroundColor,
          ),
          SizedBox(
            height: 20.h,
          ),
          ButtonApp(
            text: "حسنا",
            fontSize: 20.sp,
            fontColor: Colors.white,
            textAlign: TextAlign.center,
            iconSelect: const Icon(Icons.done_all_outlined),
            // outLineColor: ArabShooter().buttonColor,
          )
        ],
      ),
      // body: "${message.notification!.body}"
    );
  }

  forgroundFirebaseMessaging() async {
    /// this code just for forground notification
    FirebaseMessaging.onMessage.listen((event) {
      showDialogNotify(event);
      // showFlushbar(
      //   context: context,
      //   error: false,
      //   title: "${event.notification!.title}",
      //   body: "${event.notification!.body}",
      //   iconNotify:const Icon(Icons.notifications_active),
      //   time: const Duration(seconds: 20),
      //   onClick:()=>  showDialogNotify(event),
      //
      // );
      print("notification: ${event.notification!.title}");
      print("notification: ${event.notification!.body}");
    });
  }
}
