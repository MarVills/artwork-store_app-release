import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';

class ArtistCard extends StatelessWidget {
  final choice;
  final isoffline;
  final artistData;
  const ArtistCard({
    Key? key,
    required this.choice,
    required this.isoffline,
    required this.artistData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Container(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70,
                    child: Text(
                      artistData["artists_name"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      // style: Theme.of(context).textTheme.caption,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.indigo,
                      ),
                      width: 50,
                      height: 20,
                      child: Text(
                        "Follow",
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
          ],
        ),
      ),
    );
  }
}
