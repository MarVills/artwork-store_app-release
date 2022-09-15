import 'package:artwork_store/Pages/Order/orderStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Components/resusableWidgets.dart';
import '../../Texts/default.dart';
import '../../Controllers/Services/connection.dart';
import '../../Controllers/Services/query.dart';
import '../Profile/profile.dart';
import '../Cart/cartPage.dart';
import '../landingPage.dart';
import 'products.dart';
import 'artists.dart';
import '../NearBy/nearBy.dart';
import '../../Controllers/Home/LoadAllData/loadAllData.dart';
import '../Order/orderStatus.dart';

class Dashboard extends StatefulWidget {
  final action;
  final userData;
  Dashboard({Key? key, this.action = "", this.userData}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final searchController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  var hq = Hquery();

  List categories = [
    "Flowers",
    "Person",
  ];

  @override
  void initState() {
    super.initState();

    internetconnection = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          setState(() {
            isoffline = true;
          });
        } else if (result == ConnectivityResult.mobile) {
          setState(() {
            isoffline = false;
          });
        } else if (result == ConnectivityResult.wifi) {
          setState(() {
            isoffline = false;
          });
        }
      },
    );
    var userData = widget.userData;
    if (!isoffline && widget.action == "save_user") {
      saveUserDetails(userData);
    }
    setUserData();
  }

  @override
  void dispose() {
    internetconnection!.cancel();

    super.dispose();
  }

  setUserData() async {
    final userStatus = await SharedPreferences.getInstance();
    await userStatus.setString('uid', user!.uid);
    await userStatus.setString('status', "logged-in");
  }

  saveUserDetails(userData) async {
    final uid = user!.uid;
    userData["uid"] = uid;
    await hq.push("users", userData);
  }

  _signOut() async {
    await FirebaseAuth.instance.signOut();
    final userStatus = await SharedPreferences.getInstance();
    await userStatus.setString('status', "logged-out");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 48) / 2;
    final double itemWidth = size.width / 2;
    print("UID: ${user!.uid}");
    loadData();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green[200],
            titleSpacing: 0,
            actions: [
              PopupMenuButton(
                icon: userIcon(),
                onSelected: (result) {
                  switch (result) {
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            action: "profile",
                            title: lang["profile"],
                          ),
                        ),
                      );
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            action: "settings",
                            title: lang["settings"],
                          ),
                        ),
                      );
                      break;
                    case 3:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderStatusPage(),
                        ),
                      );
                      break;
                    case 4:
                      _signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LandingPage(),
                        ),
                      );
                      break;

                    default:
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Personal Information"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("Settings"),
                    value: 2,
                  ),
                  PopupMenuItem(
                    child: Text("My Purchase"),
                    value: 3,
                  ),
                  PopupMenuItem(
                    child: Text("Log-Out"),
                    value: 4,
                  ),
                ],
              ),
            ],
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Artworks Market",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      Location location = Location();
                      LocationData _currentPosition;
                      // LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
                      _currentPosition = await location.getLocation();
                      var _center = LatLng(_currentPosition.latitude!, _currentPosition.longitude!);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NearByPage(
                            currentLocation: _center,
                          ),
                        ),
                      );
                    },
                    child: locationIcon(size: 50.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ),
                      );
                    },
                    child: cartIcon(),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          width: size.width,
          height: size.height * 0.93,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.green[50],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: errmsg(
                    lang["no_internet_connection"],
                    isoffline,
                  ),
                ),
                Container(
                  // color: Colors.red,
                  width: size.width * 0.95,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * 0.77,
                        height: 50,
                        child: searchField(
                          controller: searchController,
                          hint: "Search Product",
                          hasBorder: true,
                          borderColor: Colors.grey,
                          borderRadius: 50.0,
                          // onFocusBorderColor: Colors.black,
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(1),
                            child: search_icon(),
                          ),
                          suffixFunction: () {
                            print("search clicked");
                          },
                          validator: null,
                        ),
                      ),
                      // SizedBox(width: 5),
                      PopupMenuButton(
                        icon: categoryIcon(size: 40.0, iconSize: 25.0),
                        onSelected: (result) {
                          // print(result);
                          searchController.text = result.toString();
                        },
                        itemBuilder: (context) => [
                          for (var category in categories)
                            PopupMenuItem(
                              child: Text(category),
                              value: category,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Products(isoffline: isoffline),
                SizedBox(height: 5),
                Artists(isoffline: isoffline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
