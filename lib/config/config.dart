import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ArabShooter {
  // Firebase services
  FirebaseAuth auth = FirebaseAuth.instance ;
  User? user = FirebaseAuth.instance.currentUser ;

  // Images Configures
  String logo = "assets/images/logo.png";
  String logo2 = "assets/images/logo2.png";
  String whatsIcon = "assets/images/whats_icon.png";
  String splashPhoto = "assets/images/splash.gif";
  String supportLogo = "assets/images/support_logo.png";
  String gift = "assets/images/gift.png";
  String soso = "assets/images/soso.png";
  String pp1 = "assets/images/logo_ppt.png";

  // URL Launcher WebView
  String homeWebViewPage = "https://arabshooter-sa.com/";
  String whatsAppLauncher = "https://iwtsp.com/966551546513";
  String emailAppLauncher = "arabshooter@hotmail.com";

  // Colors Configures
  Color backgroundColor = const Color(0xff142249);
  Color buttonColor = const Color(0xffFF5F42);



  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance ;
}

