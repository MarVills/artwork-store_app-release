import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../Texts/default.dart';
import '../Components/resusableWidgets.dart';
// import 'Home/splash.dart';
import '../Authentication/register.dart';
import '../Authentication/loginPage.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
                child: Text(
                  lang["elegant_paintings_being_made"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(bottom: 40),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    elevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      buttonName: lang["sign-up"],
                      btnColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 17.0,
                      isBold: true,
                      borderRadius: 8.0,
                    ),
                    elevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      buttonName: lang["log-in"],
                      btnColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 17.0,
                      isBold: true,
                      borderRadius: 8.0,
                      shadowColor: Colors.grey,
                      xOffset: -3.0,
                      yOffset: 0.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
