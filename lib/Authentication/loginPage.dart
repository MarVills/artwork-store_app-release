import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Pages/Home/dashboard.dart';
import '../Components/resusableWidgets.dart';
import '../Texts/default.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false;

  @override
  void initState() {
    setUserData();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  setUserData() async {
    final userStatus = await SharedPreferences.getInstance();
    await userStatus.setString('email', emailController.text);
    await userStatus.setString('password', passwordController.text);
    await userStatus.setString('status', "logged-in");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
          padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
          decoration: BoxDecoration(
            color: Colors.green[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Form(
                  key: _loginFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: labelText(
                            label: lang["login"].toUpperCase(),
                            fontSize: 27.0,
                            textColor: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        labelText(
                          label: "${lang["email_address"]}:",
                          textColor: Colors.black,
                        ),
                        inputField(
                          controller: emailController,
                          hasBorder: true,
                          borderRadius: 8.0,
                          borderColor: Colors.grey,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is required!";
                            } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return "Please enter a valid email address";
                            }
                          },
                        ),
                        labelText(
                          label: "${lang["password"]}:",
                          textColor: Colors.black,
                        ),
                        passwordField(
                          controller: passwordController,
                          isObscure: !isPasswordVisible,
                          isPasswordVisible: isPasswordVisible,
                          hasBorder: true,
                          borderRadius: 8.0,
                          borderColor: Colors.grey,
                          suffixFunction: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password required!";
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: elevatedButton(
                            onPressed: () async {
                              setUserData();
                              try {
                                if (validateAndSave()) {
                                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  emailController.clear();
                                  passwordController.clear();
                                  setUserData();
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => Dashboard()));
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                  _showDialog(
                                    context,
                                    "Login failed",
                                    "The email is not registered. Please register first.",
                                  );
                                } else if (e.code == 'wrong-password') {
                                  _showDialog(
                                    context,
                                    "Password is incorrect",
                                    "Please enter the correct pasword!",
                                  );
                                }
                              } catch (e) {
                                print("login error: $e");
                              }
                            },
                            buttonName: lang["log-in"],
                            btnColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 17.0,
                            isBold: true,
                            borderRadius: 8.0,
                            shadowColor: Colors.green[100],
                            xOffset: -3.0,
                            yOffset: 0.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final FormState? loginForm = _loginFormKey.currentState;
    return loginForm!.validate() ? true : false;
  }
}

void _showDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
