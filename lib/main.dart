
import 'package:arab_shooter_admin/helpers/helpers.dart';
import 'package:arab_shooter_admin/screens/webViewScreens/best_client_web_view.dart';
import 'package:arab_shooter_admin/screens/webViewScreens/send_notification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'screens/splash_init_screen.dart';
import 'screens/webViewScreens/list_notification.dart';
import 'screens/webViewScreens/support_web_view.dart';
import 'screens/webViewScreens/web_view_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget with Helpers {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(400, 800),
      builder: () => MediaQuery(
        data: const MediaQueryData(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            return Directionality(
              textDirection: TextDirection.rtl,
              child: widget!,
            );
          },
          title: 'Miraath ',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
             initialRoute: '/launch_screen',

          getPages: [
            GetPage(
              name: '/launch_screen',
              page: () => const SplashInitScreen(),
            ),
            GetPage(
              name: '/web_view_screen',
              page: () => const WebViewScreen(),
            ),
            GetPage(
              name: '/support',
              page: () => const SupportPageWebView(),
            ),
            GetPage(
              name: '/best_client',
              page: () => const BestClientPageWebView(),
            ),
            GetPage(
              name: '/notification_screen',
              page: () => const SendNotificationScreen(),
            ),
            GetPage(
              name: '/list_notification_screen',
              page: () => const ListNotifications(),
            ),
          ],
        ),
      ),
    );
  }
}
