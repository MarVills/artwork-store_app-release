// @dart=2.9
import 'package:artwork_store/Pages/Home/splash.dart';
import 'package:flutter/material.dart';
import 'Pages/Home/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Pages/Home/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget renderScreen() {
    Widget screen = SplashScreen();
    var auth = FirebaseAuth.instance;
    print("=============${auth.currentUser}=============");
    if (auth.currentUser != null) {
      screen =
          // OrderStatusPage();
          Dashboard();
    }
    return screen;
  }

  @override
  Widget build(BuildContext context) {
    requestPermision();
    renderScreen();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: renderScreen(),
      // goto(),
      // Dashboard(),
      // SplashScreen(),
      // LoginPage(),
      // RegisterScreen(),
    );
  }
}

requestPermision() async {
  if (!(await Permission.storage.request().isGranted)) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    print(statuses[Permission.location]);
  } else if (await Permission.storage.request().isDenied) {
    openAppSettings();
  }
}
