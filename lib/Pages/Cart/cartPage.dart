import 'dart:convert';
import 'package:artwork_store/Pages/Order/placeOrder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Components/resusableWidgets.dart';
import '../../Controllers/Services/query.dart';
import '../../Components/dialogs.dart';

class CartPage extends StatefulWidget {
  final title;
  final action;
  final itemData;
  CartPage({
    Key? key,
    this.title = "Cart",
    this.action = "",
    this.itemData = const [],
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final searchController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final birthdayController = TextEditingController();
  final contactNoController = TextEditingController();
  bool isSelected = false;
  bool isAllSelected = false;
  List userCart = [];
  List itemDataList = [];
  Map cartData = {};
  Map classifiedItems = {};
  var cartItemId;
  var hq = Hquery();
  var artistItems = "";

  updateItemsToCart({action: ""}) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> itemsList = prefs.getStringList("items") ?? [];

    if (action == "") {
      userCart = [];
      userCart.addAll(widget.itemData);

      if (itemsList.isNotEmpty) {
        itemsList.forEach((element) {
          userCart.add(json.decode(element));
        });
      }
    }
    print(await prefs.remove("items"));
    itemsList = [];

    userCart.forEach((element) {
      itemsList.add(json.encode(element));
    });
    await prefs.setStringList("items", itemsList);
  }

  List<List> organizedItems(list) {
    List<List> finalList = [];
    List artistIds = [];

    for (var item in list) {
      artistIds.add(item["artist_id"]);
    }
    var noRepeatId = artistIds.toSet().toList();
    for (var ids in noRepeatId) {
      List itemByArtist = [];

      for (var item in list) {
        if (item["artist_id"] == ids) {
          itemByArtist.add(item);
        }
      }

      finalList.add(itemByArtist);
    }

    return finalList;
  }

  refreshState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
  }

  @override
  void initState() {
    updateItemsToCart();
    refreshState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        await updateItemsToCart(action: "updateOnPop");
        // await hq.update("categories", cartItemId, cartData);
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
          child: Container(
            width: size.width * 0.9,
            height: size.height * 0.7,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: RefreshIndicator(
              onRefresh: () {
                setState(() {});
                return Future.delayed(
                  Duration(seconds: 2),
                );
              },
              child: ListView(
                // padding: EdgeInsets.all(),
                children: <Widget>[
                  for (var items in organizedItems(userCart))
                    Wrap(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              radioButton(
                                groupValue: artistItems,
                                value: items[0]["artist_id"],
                                onChanged: (value) {
                                  artistItems = value;
                                  setState(() {});
                                },
                              ),
                              for (var item in items)
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     item["is_selected"] = !item["is_selected"];
                                      //     setState(() {});
                                      //   },
                                      //   child: customCheckBox(
                                      //     isChecked: item["is_selected"],
                                      //   ),
                                      // ),
                                      SizedBox(width: 15),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            alignment: Alignment.centerLeft,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.green[100],
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text(
                                              item["product_name"],
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            // disabledField(
                                            //   controller: controller,
                                            //   contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                            // ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      GestureDetector(
                                        onTap: () {
                                          showAlertDialog(
                                            context: context,
                                            title: "Delete",
                                            content: "Are you sure you want to Delete this Item?",
                                            onTapYes: () {
                                              userCart.removeWhere((i) => i == item);
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                            onTapNo: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                        child: Icon(FontAwesomeIcons.trash),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  SizedBox(height: 20),
                  expandedButton(
                    buttonName: "Place Order",
                    shadowColor: Colors.green[200],
                    onPressed: () {
                      var ordersToPlace = [];
                      for (var items in organizedItems(userCart)) {
                        for (var item in items) {
                          if (item["artist_id"] == artistItems) {
                            ordersToPlace.add(item);
                            // userCart.remove(item);
                            // setState(() {});
                          }
                        }
                      }

                      if (ordersToPlace.isEmpty) {
                        showConfirmDialog(
                          context: context,
                          title: "No Orders to Place",
                          content: "You have not selected any items yet. Please select items before placing order.",
                          onTapOk: () {
                            Navigator.pop(context);
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PlaceOrderPage(placeItems: ordersToPlace)),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
