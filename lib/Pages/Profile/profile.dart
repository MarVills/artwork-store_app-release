import 'package:artwork_store/Components/dialogs.dart';
import 'package:artwork_store/Pages/Home/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Components/resusableWidgets.dart';
import '../../Texts/default.dart';
import '../../Controllers/Services/query.dart';
import '../Home/dashboard.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  final title;
  final action;
  ProfilePage({Key? key, this.title = "Profile", this.action = ""}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _profileFormKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final birthdayController = TextEditingController();
  final _birthdayController = TextEditingController();
  final contactNoController = TextEditingController();
  List userData = [];
  var hq = Hquery();
  final user = FirebaseAuth.instance.currentUser;
  var formatter = DateFormat("dd-MMM-yy");

  setUpProfile() {
    for (var data in userData) {
      if (user!.uid == data["uid"]) {
        firstNameController.text = data["first_name"];
        lastNameController.text = data["last_name"];
        emailController.text = data["email_address"];
        addressController.text = data["address"];
        birthdayController.text = data["birthday"];
        _birthdayController.text = data["birthday"];
        contactNoController.text = data["contact"];
      }
    }
  }

  refreshState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
      setUpProfile();
    });
  }

  @override
  void initState() {
    refreshState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ),
        );
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            // automaticallyImplyLeading: false,
            backgroundColor: Colors.green[200],
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleSpacing: 0,
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          width: size.width,
          height: size.height * 0.93,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.green[50],
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: hq.getSnap("users"),
            builder: (gContext, snapshot) {
              if (snapshot.hasData) {
                userData = snapshot.data!.docs;
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.action == "profile"
                        ? Container(
                            width: size.width * 0.9,
                            height: size.height * 0.7,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "User Information",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 15),
                                detailLabel(
                                  label: lang["first_name"],
                                  value: firstNameController.text,
                                ),
                                detailLabel(
                                  label: lang["last_name"],
                                  value: lastNameController.text,
                                ),
                                detailLabel(
                                  label: lang["email_address"],
                                  value: emailController.text,
                                ),
                                detailLabel(
                                  label: lang["address"],
                                  value: addressController.text,
                                ),
                                detailLabel(
                                  label: lang["birthday"],
                                  value: birthdayController.text,
                                ),
                                detailLabel(
                                  label: lang['contact_number'],
                                  value: contactNoController.text,
                                ),
                                SizedBox(height: 30),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  child: expandedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfilePage(
                                            action: "settings",
                                            title: lang["settings"],
                                          ),
                                        ),
                                      );
                                    },
                                    buttonName: "Edit",
                                    shadowColor: Colors.green[100],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: size.width * 0.9,
                            // height: size.height * 0.7,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Form(
                              key: _profileFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "User Information",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  labelText(
                                    label: "${lang["first_name"]}:",
                                    textColor: Colors.black,
                                  ),
                                  inputField(
                                    controller: firstNameController,
                                    hasBorder: true,
                                    borderRadius: 8.0,
                                    borderColor: Colors.grey,
                                    fieldColor: Colors.green[100],
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
                                    fieldColor: Colors.green[100],
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
                                    fieldColor: Colors.green[100],
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
                                  GestureDetector(
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate:
                                                  // birthdayController.text == ""
                                                  DateTime.now(),
                                              // : DateTime.parse(_birthdayController.text + " " + "00:00:00"),
                                              firstDate: DateTime(1920),
                                              lastDate: DateTime(DateTime.now().year + 5),
                                              currentDate: DateTime.now())
                                          .then((value) {
                                        if (value != null) {
                                          birthdayController.text = formatter.format(value);
                                          _birthdayController.text = DateFormat('dd-MMM-yy').format(value);
                                        }
                                      });
                                    },
                                    child: inputField(
                                      enabled: false,
                                      controller: birthdayController,
                                      hasBorder: true,
                                      borderRadius: 8.0,
                                      borderColor: Colors.grey,
                                      fieldColor: Colors.green[100],
                                      validator: null,
                                    ),
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
                                    fieldColor: Colors.green[100],
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
                                    fieldColor: Colors.green[100],
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Address number is required";
                                      }
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 30),
                                    child: expandedButton(
                                      onPressed: () async {
                                        if (validateAndSave()) {
                                          for (var appUser in userData) {
                                            if (appUser["uid"] == user!.uid) {
                                              await hq.update("users", appUser.id, {
                                                "address": addressController.text,
                                                "birthday": birthdayController.text,
                                                "contact": contactNoController.text,
                                                "email_address": emailController.text,
                                                "first_name": firstNameController.text,
                                                "last_name": lastNameController.text,
                                              });

                                              showConfirmDialog(
                                                context: context,
                                                title: "Update",
                                                content: "Your Account has been Updated.",
                                                onTapOk: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ProfilePage(
                                                        action: "profile",
                                                        title: lang["profile"],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          }
                                        }
                                      },
                                      buttonName: "Save",
                                      shadowColor: Colors.green[100],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final FormState? loginForm = _profileFormKey.currentState;
    return loginForm!.validate() ? true : false;
  }
}
