import 'package:artwork_store/Controllers/Services/moneyConvert.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import '../../Texts/default.dart';
import '../Home/dashboard.dart';
import '../../Controllers/Services/query.dart';

class OrderStatusPage extends StatefulWidget {
  OrderStatusPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  var hq = Hquery();

  refreshState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
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
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.green[200],
          title: Text(
            lang["order_status"],
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          height: size.height,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20, left: 15, right: 15),
          child: StreamBuilder(
            stream: hq.getSnap("ordered_products"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List toPay = [];
              List toShip = [];
              List toRecieve = [];
              List completed = [];
              List canceled = [];
              if (snapshot.hasData) {
                var rawData = snapshot.data!.docs;
                for (var item in rawData) {
                  if (item["status"] == "toPay") {
                    toPay.add(item);
                  }
                }
                for (var item in rawData) {
                  if (item["status"] == "toShip") {
                    toShip.add(item);
                  }
                }
                for (var item in rawData) {
                  if (item["status"] == "toRecieve") {
                    toRecieve.add(item);
                  }
                }
                for (var item in rawData) {
                  if (item["status"] == "completed") {
                    completed.add(item);
                  }
                }
                for (var item in rawData) {
                  if (item["status"] == "canceled") {
                    canceled.add(item);
                  }
                }
              }
              return ContainedTabBarView(
                tabBarProperties: TabBarProperties(
                  isScrollable: true,
                  width: size.width,
                  height: 40,
                  indicator: ContainerTabIndicator(
                    color: Colors.green,
                    radius: BorderRadius.circular(3.0),
                  ),
                  indicatorColor: Colors.green,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  background: Container(
                    color: Colors.green[50],
                  ),
                ),
                tabs: [
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text('To Pay'),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text('To Ship'),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text('To Recive'),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text('Completed'),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text('Canceled'),
                    ),
                  ),
                ],
                views: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: size.width,
                      height: size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var item in toPay)
                              statusOrderTile(
                                productName: item["product_name"],
                                price: item["price"],
                                artist: item["artist_name"],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: size.width,
                      height: size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var item in toShip)
                              statusOrderTile(
                                productName: item["product_name"],
                                price: item["price"],
                                artist: item["artist_name"],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: size.width,
                      height: size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var item in toRecieve)
                              statusOrderTile(
                                productName: item["product_name"],
                                price: item["price"],
                                artist: item["artist_name"],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: size.width,
                      height: size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var item in completed)
                              statusOrderTile(
                                productName: item["product_name"],
                                price: item["price"],
                                artist: item["artist_name"],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: size.width,
                      height: size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var item in canceled)
                              statusOrderTile(
                                productName: item["product_name"],
                                price: item["price"],
                                artist: item["artist_name"],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ),
            );
          },
          child: Icon(Icons.home),
        ),
      ),
    );
  }

  Widget statusOrderTile({required productName, required price, required artist}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Artist: " + artist,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            setMoney(price),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  setMoney(money) {
    return toMoney(val: double.parse(money), isDouble: true).toString();
  }
}
