import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../Components/resusableWidgets.dart';
import '../../Texts/default.dart';
import '../../Controllers/Services/query.dart';
import '../../Controllers/Services/getImageName.dart';
import '../../Components/dialogs.dart';

class ArtistPage extends StatefulWidget {
  final imageUrl;
  ArtistPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  final searchController = TextEditingController();
  var hq = Hquery();
  var artistData = [];
  var artistName = "";
  var address = "";
  var contactNumber = "";
  var emailAddress = "";

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
                  lang["artist_details"],
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.green[50],
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: hq.getSnap("artists"),
          builder: (gContext, snapshot) {
            final user = FirebaseAuth.instance.currentUser;
            if (snapshot.hasData) {
              artistData = snapshot.data!.docs;
            }

            for (var data in artistData) {
              if (getImageName(url: widget.imageUrl) == data.id) {
                artistName = data["artists_name"];
                address = data["address"];
                contactNumber = data["contact_number"];
                emailAddress = data["email_address"];
              }
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: size.width * 0.9,
                    // height: size.height * 0.7,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showPictureDialog(
                                context: context,
                                image: widget.imageUrl,
                                size: size,
                              );
                            },
                            child: Container(
                              height: size.height * 0.4,
                              width: size.width * 0.6,
                              margin: EdgeInsets.only(bottom: 20, top: 20),
                              decoration: BoxDecoration(
                                color: Colors.green[200],
                                image: DecorationImage(
                                  image: NetworkImage(widget.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          expandedButton(
                            onPressed: () {},
                            buttonName: lang["contact_seller"],
                            btnColor: Colors.green,
                            shadowColor: Colors.green[100],
                            xmargin: 40.0,
                          ),
                          expandedButton(
                            onPressed: () {},
                            buttonName: lang["follow"],
                            btnColor: Colors.indigo,
                            shadowColor: Colors.green[100],
                            xmargin: 40.0,
                          ),
                          Container(
                            height: size.height * 0.5,
                            width: size.width * 0.85,
                            margin: EdgeInsets.only(bottom: 20, top: 20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  artistName,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(height: 10),
                                detailLabel(label: "Address", value: address),
                                SizedBox(height: 7),
                                detailLabel(label: "Contact Number", value: contactNumber),
                                SizedBox(height: 5),
                                detailLabel(label: "Email Address", value: emailAddress),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
