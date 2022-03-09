import 'package:arab_shooter_admin/config/config.dart';
import 'package:flutter/material.dart';

class SplashInitScreen extends StatefulWidget {
  const SplashInitScreen({Key? key}) : super(key: key);

  @override
  _SplashInitScreenState createState() => _SplashInitScreenState();
}

class _SplashInitScreenState extends State<SplashInitScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 4800), () {
      if (ArabShooter().user == null) {
        ArabShooter().auth.signInAnonymously();
      }

      Navigator.pushReplacementNamed(context, '/web_view_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ArabShooter().splashPhoto), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
