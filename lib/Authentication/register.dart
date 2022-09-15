import 'package:artwork_store/Pages/Home/dashboard.dart';
import 'package:artwork_store/Components/resusableWidgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import '../Texts/default.dart';
import '../Controllers/Services/query.dart';

// import 'package:provider/provider.dart';
// import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _scaffold = GlobalKey<ScaffoldState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final birthdayController = TextEditingController();
  final contactNoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordCtrlr = TextEditingController();

  var isPasswordVisible = false;
  var isConfirmPasswordVisible = false;

  var hq = Hquery();

  // bool _isObscure1 = true;
  // bool _isObscure2 = true;
  bool isVisible = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    birthdayController.dispose();
    contactNoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordCtrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // final auth = Provider.of<AuthService>(context);

    return Scaffold(
      key: _scaffold,
      // appBar: AppBar(
      //   title: Text("Register Account"),
      // ),
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
          padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.green[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: labelText(
                      label: lang["create_account"],
                      fontSize: 27.0,
                      textColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  labelText(
                    label: "${lang["first_name"]}:",
                    textColor: Colors.black,
                  ),
                  inputField(
                    controller: firstNameController,
                    hasBorder: true,
                    borderRadius: 8.0,
                    borderColor: Colors.grey,
                    validator: (value) {
                      // print("print bool : ${value.isEmpty}");
                      if (value.isEmpty) {
                        return "First name is required";
                      }
                    },
                  ),
                  labelText(
                    label: "${lang["last_name"]}:",
                    textColor: Colors.black,
                  ),
                  inputField(
                    controller: lastNameController,
                    hasBorder: true,
                    borderRadius: 8.0,
                    borderColor: Colors.grey,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Last name is required";
                      }
                    },
                  ),
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
                      if (value.isEmpty) {
                        return "Email is required!";
                      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                    },
                  ),
                  labelText(
                    label: "${lang["birthday"]}:",
                    textColor: Colors.black,
                  ),
                  inputField(
                    controller: birthdayController,
                    hasBorder: true,
                    borderRadius: 8.0,
                    borderColor: Colors.grey,
                    validator: null,
                  ),
                  labelText(
                    label: "${lang["contact_no"]}:",
                    textColor: Colors.black,
                  ),
                  inputField(
                    controller: contactNoController,
                    hasBorder: true,
                    borderRadius: 8.0,
                    borderColor: Colors.grey,
                    type: TextInputType.phone,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Contact number is required";
                      }
                    },
                  ),
                  labelText(
                    label: "${lang["address"]}:",
                    textColor: Colors.black,
                  ),
                  inputField(
                    controller: addressController,
                    hasBorder: true,
                    borderRadius: 8.0,
                    borderColor: Colors.grey,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Address number is required";
                      }
                    },
                  ),
                  labelText(
                    label: "${lang["password"]}:",
                    textColor: Colors.black,
                  ),
                  passwordField(
                    controller: passwordController,
                    hasBorder: true,
                    borderRadius: 8.0,
                    borderColor: Colors.grey,
                    isObscure: !isPasswordVisible,
                    isPasswordVisible: isPasswordVisible,
                    suffixFunction: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password required!";
                      } else if (value.length < 6) {
                        return "The password must contain atleast 6 characters!";
                      } else if (!value.contains(RegExp(r'[A-Z]'))) {
                        return "The password must contain atleast one capital letter!";
                      } else if (!value.contains(RegExp(r'[0-9]{3}'))) {
                        return "The password must contain atleat 3 numbers!";
                      } else if (!value.contains(RegExp(r"[.!#$%&\@'*+/=?^_`{|}~-]"))) {
                        //(?=.*[!@#$%^&*])
                        return "The password must contain atleast one special character";
                      }
                    },
                  ),
                  labelText(
                    label: "${lang["confirm_password"]}:",
                    textColor: Colors.black,
                  ),
                  passwordField(
                    controller: confirmPasswordCtrlr,
                    hasBorder: true,
                    borderRadius: 8.0,
                    borderColor: Colors.grey,
                    isObscure: !isConfirmPasswordVisible,
                    isPasswordVisible: isConfirmPasswordVisible,
                    suffixFunction: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Confirm password required!";
                      } else if (value != passwordController.text) {
                        return "Password doesn't match!";
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: elevatedButton(
                      onPressed: () async {
                        try {
                          if (validateAndSave() & EmailValidator.validate(emailController.text)) {
                            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: confirmPasswordCtrlr.text.trim(),
                            );
                            // hq.push("users", "")
                            await _showDialog(
                              context: context,
                              title: "Your account has been registered!",
                              content: "please signin your account",
                              status: "success",
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "invalid-email") {
                            _showDialog(context: context, title: "Invalid email", content: "Please enter a valid email!");
                          } else if (e.code == "email-already-in-use") {
                            _showDialog(context: context, title: "Email already exist", content: "Please enter another email.");
                          } else {
                            print("Register Error : $e");
                          }
                        } catch (e) {
                          print("Register Error : $e");
                        }
                      },
                      buttonName: lang["sign-up"],
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
        ),
      ),
    );
  }

  bool validateAndSave() {
    final FormState? form = _formKey.currentState;
    return form!.validate() ? true : false;
  }

  _showDialog({required context, required title, required content, status: "still"}) async {
    showDialog(
      barrierDismissible: false,
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
                if (status == "success")
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(
                        action: "save_user",
                        userData: {
                          "first_name": firstNameController.text,
                          "last_name": lastNameController.text,
                          "email_address": emailController.text,
                          "birthday": birthdayController.text,
                          "contact": contactNoController.text,
                          "address": addressController.text,
                        },
                      ),
                    ),
                  );
              },
            ),
          ],
        );
      },
    );
  }
}
