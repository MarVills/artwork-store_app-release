import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Controllers/Services/query.dart';
import '../../Controllers/Services/getAllImage.dart';
import '../Artist/artistPage.dart';
import '../../Controllers/Services/getImageName.dart';
import 'artistsCard.dart';

class Artists extends StatefulWidget {
  final isoffline;

  Artists({
    Key? key,
    this.isoffline,
  }) : super(key: key);

  @override
  _ArtistsState createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {
  final searchController = TextEditingController();
  var artistData = {};
  var hq = Hquery();
  List<String> urlList = [];

  setUrlList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('urls', urlList);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 48) / 2;
    final double itemWidth = size.width / 2;

    List userData = [];
    return Container(
      color: Colors.transparent,
      height: size.height * 0.2,
      width: size.width * 0.9,
      child: FutureBuilder(
        future: loadImages(path: "artists"),
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
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: ((itemWidth - 20) / itemWidth),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: List.generate(
                  snapshot.data?.length ?? 0,
                  (index) {
                    final Map<String, dynamic> image = snapshot.data![index];
                    urlList.add(image["url"]);
                    setUrlList();

                    return StreamBuilder<QuerySnapshot>(
                      stream: hq.getSnap("artists"),
                      builder: (gContext, snapshot) {
                        final auth = FirebaseAuth.instance;
                        // ignore: unused_local_variable
                        final user = auth.currentUser;
                        if (snapshot.hasData) {
                          userData = snapshot.data!.docs;
                        }
                        // print(userData);
                        for (var data in userData) {
                          // print("see image: $image");
                          // if (widget.artistId != "" && data.id == widget.artistId) {
                          //   artistData["artists_name"] = data["artists_name"];
                          //   artistData["address"] = data["address"];
                          //   artistData["contact_number"] = data["contact_number"];
                          //   artistData["email_address"] = data["email_address"];
                          // } else
                          if (getImageName(url: image["url"]) == data.id) {
                            artistData["artists_name"] = data["artists_name"];
                            artistData["address"] = data["address"];
                            artistData["contact_number"] = data["contact_number"];
                            artistData["email_address"] = data["email_address"];
                          }
                        }
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArtistPage(
                                    imageUrl: image['url'],
                                  ),
                                ),
                              );
                            },
                            child: ArtistCard(
                              choice: image,
                              isoffline: widget.isoffline,
                              artistData: artistData,
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
