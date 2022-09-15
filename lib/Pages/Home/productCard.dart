import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';

class ProductCard extends StatelessWidget {
  final choice;
  final isoffline;
  final productData;
  const ProductCard({
    Key? key,
    required this.choice,
    required this.isoffline,
    required this.productData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    var size = MediaQuery.of(context).size;

    return Card(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green[200],
                  image: DecorationImage(
                    image: NetworkImage(choice['url']),
                    fit: BoxFit.cover,
                  ),
                ),
                // child: Image.network(choice['url'], placeholder: AssetImage(assetName)),
                child: isoffline
                    ? Center(
                        child: Icon(Icons.image, color: Colors.grey),
                      )
                    : null,
              ),
            ),
            AutoSizeText(
              productData["item_name"],
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            // Text(
            //   // "",
            //   productData["item_name"],
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            Text(
              // "",
              productData["price"],
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
