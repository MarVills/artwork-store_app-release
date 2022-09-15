import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../../Texts/default.dart';
import '../../Components/resusableWidgets.dart';
import '../landingPage.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  delay() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      // setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    });
  }

  @override
  void initState() {
    delay();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var black = Color(0xFF000000);
    var white = Color(0xFFFFFFFF);

    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/am_logo.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ));
  }
}
