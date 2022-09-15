import 'package:artwork_store/Controllers/Services/moneyConvert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../Texts/default.dart';
import '../../Components/orderTile.dart';
import '../../Components/resusableWidgets.dart';
import '../../Controllers/Services/query.dart';
import 'orderStatus.dart';

class PlaceOrderPage extends StatefulWidget {
  final placeItems;
  PlaceOrderPage({
    Key? key,
    required this.placeItems,
  }) : super(key: key);

  @override
  State<PlaceOrderPage> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  final GlobalKey<FormState> _placeOrderFormKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final contactNumberController = TextEditingController();
  final itemsController = TextEditingController();
  String? paymentMethod = "COD";
  var totalAmount = 0.00;
  var hq = Hquery();

  @override
  void initState() {
    for (var item in widget.placeItems) {
      totalAmount += double.parse(item["price"]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.green[200],
        title: Text(
          lang["place_order"],
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
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            for (var item in widget.placeItems)
              orderTile(
                productName: item["product_name"],
                price: item["price"],
                itemsAvailable: item["items_available"],
              ),
            SizedBox(height: 10.0),
            Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  Spacer(),
                  Text(
                    toMoney(val: totalAmount, isDouble: true).toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Payment Method",
                style: TextStyle(fontSize: 20),
              ),
            ),
            RadioListTile(
              title: Text("Cash On Delivery"),
              value: "COD",
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                  print(paymentMethod);
                });
              },
            ),
            RadioListTile(
              title: Text("Other Mehtods"),
              value: "Other Methods",
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                  print(paymentMethod);
                });
              },
            ),
            SizedBox(height: 20.0),
            if (paymentMethod == "Other Methods")
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Upload yout receipt here and \n wait for seller's Confirmation",
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Form(
                key: _placeOrderFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      label: "Address to deliver",
                      textColor: Colors.black,
                    ),
                    inputField(
                      controller: addressController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required.";
                        }
                      },
                    ),
                    labelText(
                      label: "Email Address",
                      textColor: Colors.black,
                    ),
                    inputField(
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required.";
                        } else {
                          if (EmailValidator.validate(emailController.text)) {
                            return null;
                          } else {
                            return "Please enter a valid email";
                          }
                        }
                      },
                    ),
                    labelText(
                      label: "Contact Number",
                      textColor: Colors.black,
                    ),
                    inputField(
                      controller: contactNumberController,
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required.";
                        }
                      },
                    ),
                    if (widget.placeItems.length == 1)
                      Wrap(
                        children: [
                          labelText(
                            label: "Items",
                            textColor: Colors.black,
                          ),
                          inputField(
                            controller: itemsController,
                            type: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "This field is required.";
                              }
                            },
                          ),
                        ],
                      ),
                    SizedBox(height: 20),
                    expandedButton(
                      onPressed: () async {
                        if (validateAndSave()) {
                          for (var item in widget.placeItems) {
                            await hq.push(
                              "ordered_products",
                              {
                                "product_id": item["product_id"],
                                "artist_id": item["artist_id"],
                                "product_name": item["product_name"],
                                "artist_name": item["artist_name"],
                                "status": "toPay",
                                "price": item["price"],
                                "customer_address": addressController.text,
                                "customer_email_address": emailController.text,
                                "customer_contact_number": contactNumberController.text,
                                "pieces": itemsController.text,
                                "payment_method": paymentMethod,
                              },
                            );
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrderStatusPage()),
                          );
                        }
                      },
                      buttonName: "Check Out",
                      shadowColor: Colors.green[100],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final FormState? loginForm = _placeOrderFormKey.currentState;
    return loginForm!.validate() ? true : false;
  }
}
