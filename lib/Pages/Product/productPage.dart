import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Components/resusableWidgets.dart';
import '../../Texts/default.dart';
import '../Cart/cartPage.dart';
import '../../Controllers/Services/query.dart';
import '../../Controllers/Services/getImageName.dart';
import '../../Components/dialogs.dart';
import '../../Controllers/Services/moneyConvert.dart';
import '../Artist/artistPage.dart';
import '../Order/placeOrder.dart';
import '../Cart/cartPage.dart';

class ProductPage extends StatefulWidget {
  final imageUrl;
  ProductPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var hq = Hquery();
  var artName = "";
  var description = "";
  var artistName = "";
  var madeIn = "";
  var price = "";
  var itemsAvailable = "";
  var category = "";
  var productId = "";
  var artistId = "";
  List userData = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
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
                  "Product Details",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: hq.getSnap("products"),
          builder: (gContext, snapshot) {
            final user = FirebaseAuth.instance.currentUser;
            if (snapshot.hasData) {
              userData = snapshot.data!.docs;
            }
            // print(userData);
            for (var data in userData) {
              if (getImageName(url: widget.imageUrl) == data.id) {
                productId = data.id;
                artistId = data["artist_id"];
                artName = data["item_name"];
                description = data["description"];
                artistName = data["artist_name"];
                madeIn = data["made_in"];
                category = data["category"];
                price = data["price"].toString();
                itemsAvailable = data["items_available"].toString();
              }
            }
            return Container(
              width: size.width * 0.9,
              // height: size.height * 0.7,
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      // fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Container(
                          width: size.width,
                          height: 80,
                          color: Colors.green[200],
                        ), //Container
                        Align(
                          alignment: Alignment.center,

                          // left: (size.width * 0.5) - 40,

                          child: GestureDetector(
                            onTap: () {
                              showPictureDialog(
                                context: context,
                                image: widget.imageUrl,
                                size: size,
                              );
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              margin: EdgeInsets.only(bottom: 20, top: 15),
                              decoration: BoxDecoration(
                                color: Colors.green[200],
                                image: DecorationImage(
                                  image: NetworkImage(widget.imageUrl),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: size.width,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                detailLabel(label: "Artist name", value: artistName),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.indigo,
                                    ),
                                    width: 60,
                                    height: 20,
                                    child: Text(
                                      lang["follow"],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          detailLabel(label: "Art name", value: artName),
                          Container(
                            height: 20,
                            width: 130,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.lime[900],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              toMoney(val: price),
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          ovalButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartPage(
                                    itemData: [
                                      {
                                        "is_selected": false,
                                        "product_name": artName,
                                        "product_id": productId,
                                        "artist_id": artistId,
                                        "artist_name": artistName,
                                        "price": price,
                                        "items_available": itemsAvailable,
                                      }
                                    ],
                                  ),
                                ),
                              );
                            },
                            buttonName: lang["add_to_cart"],
                            btnColor: Colors.green,
                            shadowColor: Colors.green[100],
                            xmargin: 40.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // height: size.height * 0.8,
                      width: size.width * 0.85,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Artwork Details",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(description),
                          SizedBox(height: 7),
                          detailLabel(label: "Made in", value: madeIn),
                          SizedBox(height: 5),
                          detailLabel(label: "Category", value: category),
                          SizedBox(height: 5),
                          detailLabel(label: "Items Available", value: itemsAvailable),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          expandedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlaceOrderPage(
                                    placeItems: [
                                      {
                                        "product_name": artName,
                                        "product_id": productId,
                                        "artist_id": artistId,
                                        "artist_name": artistName,
                                        "price": price,
                                        "items_available": itemsAvailable,
                                      }
                                    ],
                                  ),
                                ),
                              );
                            },
                            buttonName: lang["place_order"],
                            btnColor: Colors.green,
                            shadowColor: Colors.green[100],
                            xmargin: 40.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About the Artist",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () async {
                              final prefs = await SharedPreferences.getInstance();
                              List<String>? urlList = prefs.getStringList('urls');
                              for (var url in urlList!) {
                                print("====${getImageName(url: url)}===${artistId}===");
                                if (getImageName(url: url) == artistId) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArtistPage(imageUrl: url),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  userIcon(size: 50.0, bgColor: Colors.purple, iconColor: Colors.white),
                                  SizedBox(width: 15),
                                  Text(
                                    artistName,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
