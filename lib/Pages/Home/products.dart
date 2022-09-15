import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Controllers/Services/query.dart';
import 'productCard.dart';
import '../../Controllers/Services/getAllImage.dart';
import '../Product/productPage.dart';
import '../../Controllers/Services/getImageName.dart';
import '../../Controllers/Services/moneyConvert.dart';

class Products extends StatefulWidget {
  final isoffline;
  Products({
    Key? key,
    required this.isoffline,
  }) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final searchController = TextEditingController();

  var productData = {};

  var hq = Hquery();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 48) / 2;
    final double itemWidth = size.width / 2;

    List userData = [];
    return Container(
      color: Colors.transparent,
      height: size.height * 0.58,
      width: size.width * 0.9,
      child: FutureBuilder(
        future: loadImages(path: "art_product"),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // var snapData = snapshot.data!.docs;

            return RefreshIndicator(
              onRefresh: () {
                setState(() {});
                return Future.delayed(
                  Duration(seconds: 2),
                );
              },
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: (itemWidth / itemHeight),
                padding: EdgeInsets.symmetric(horizontal: 30),
                children: List.generate(
                  snapshot.data?.length ?? 0,
                  (index) {
                    final Map<String, dynamic> image = snapshot.data![index];

                    return StreamBuilder<QuerySnapshot>(
                      stream: hq.getSnap("products"),
                      builder: (gContext, snapshot) {
                        final auth = FirebaseAuth.instance;
                        final user = auth.currentUser;
                        if (snapshot.hasData) {
                          userData = snapshot.data!.docs;
                        }
                        // print(userData);
                        for (var data in userData) {
                          // print("see image: $image");
                          if (getImageName(url: image["url"]) == data.id) {
                            productData["item_name"] = data["item_name"];
                            productData["description"] = data["description"];
                            productData["artist_name"] = data["artist_name"];
                            productData["made_in"] = data["made_in"];
                            var price = data["price"].toString();
                            productData["price"] = toMoney(val: price);

                            productData["items_available"] = data["items_available"].toString();
                          }
                        }
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    imageUrl: image['url'],
                                  ),
                                ),
                              );
                            },
                            child: ProductCard(
                              choice: image,
                              isoffline: widget.isoffline,
                              productData: productData,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
