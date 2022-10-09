import 'dart:convert';
import 'dart:io';
import 'dart:async';

import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:icounselgh/HomePage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Review extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Review> {
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // openwhatsapp(String hisnumber) async {
  //   var whatsapp = "+233204200444";
  //   var whatsappURl_android =
  //       "whatsapp://send?phone=" + hisnumber + "&text=hello";
  //   var whatappURL_ios = "https://wa.me/$hisnumber?text=${Uri.parse("hello")}";
  //   if (Platform.isIOS) {
  //     // for iOS phone only
  //     if (await canLaunch(whatappURL_ios)) {
  //       await launch(whatappURL_ios, forceSafariVC: false);
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
  //     }
  //   } else {
  //     // android , web
  //     if (await canLaunch(whatsappURl_android)) {
  //       await launch(whatsappURl_android);
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
  //     }
  //   }
  // }

  openwhatsapp() async {
    var whatsapp = "+919144040888";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

//  final TextEditingController _ratingController ; /
  double _rating;
  var r1 = 0;
  var r2 = 0;
  var r3 = 0;
  var r4 = 0;
  var r5 = "";
  var r6 = "inactive";
  var _comment = TextEditingController();

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  // IconData? _selectedIcon;

  initState() {
    super.initState();
    var _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  Future cratings() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    var username = box.get("uname");
    var userlink = "https://icounselgh.net/addratings";
    var response = await http.post(
      Uri.parse(userlink),
      body: {
        'id': userid.toString(),
        'uname': username.toString(),
        'a2': r1.toString(),
        'a3': r2.toString(),
        'a4': r3.toString(),
        'a5': r4.toString(),
        'a6': _comment.text.toString(),
        'a7': r6.toString(),
        // 'a8': _comment.text.toString(),
      },
    );
    var result = jsonDecode(response.body);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenheight * 0.05,
          ),

          Container(
            margin: EdgeInsets.only(
                left: screenwidth * 0.05, right: screenwidth * 0.05),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xfffaab3b),
            ),
            child: Text(
              "Kindly rate our services as well as the Counsellors/Psychologists. You can also view other people's experience with Counsel-Me.'",
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Service Delivery         ",
                  style: GoogleFonts.montserrat(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Card(
                    elevation: 5,
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey[200],
                      ),
                      child: RatingBar.builder(
                        initialRating: 0,
                        itemSize: 20,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                          setState(() {
                            r1 = rating.toInt();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Client satisfaction ",
                  style: GoogleFonts.montserrat(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Card(
                    elevation: 5,
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                      ),
                      child: RatingBar.builder(
                        initialRating: 0,
                        itemSize: 20,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                          setState(() {
                            r2 = rating.toInt();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Counsellor \nperformance  ",
                  style: GoogleFonts.montserrat(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: Card(
                    elevation: 5,
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                      ),
                      child: RatingBar.builder(
                        initialRating: 0,
                        itemSize: 20,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                          setState(() {
                            r3 = rating.toInt();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Affordability of \nservice",
                  style: GoogleFonts.montserrat(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Card(
                    elevation: 5,
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                      ),
                      child: RatingBar.builder(
                        initialRating: 0,
                        itemSize: 20,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                          setState(() {
                            r4 = rating.toInt();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 15,
          ),

          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red, //this has no effect
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "  General comment: ...",
              ),
              controller: _comment,
            ),
          ),

          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              SweetAlert.show(
                context,
                title: "Loading ..",
                subtitle: "Please wait...",
                style: SweetAlertStyle.loading,
              );

              var repo = await cratings();

              if (repo == "pendingcomment") {
                SweetAlert.show(
                  context,
                  title: "Oops",
                  subtitle: "Your already have pending comment",
                  style: SweetAlertStyle.error,
                );
              } else if (repo == "sent") {
                SweetAlert.show(
                  context,
                  title: "Congrats!",
                  subtitle: "Your rating is submitted for review .",
                  style: SweetAlertStyle.success,
                );
                // print(resp);

                Future.delayed(Duration(seconds: 4), () {
                  // Navigator.of(context).pop();
                  Route route = MaterialPageRoute(builder: (c) => HomeScreen());
                  Navigator.pushReplacement(context, route);
                });
              } else if (repo == "failed") {
                SweetAlert.show(
                  context,
                  title: "Warning",
                  subtitle: "Failed to submit form",
                  style: SweetAlertStyle.error,
                );
              }
            },
            // textColor: Colors.white,
            // padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFFFF7d33),
                    Color(0xFFFFbb33),
                    Color(0xFFFFe033),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child: const Text('SUBMIT'),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          SingleChildScrollView(
            child: RatingBox(),
          ),

          // Expanded(child: ActivityTile()),
          // ActivityTileInstant(),
          // ActivityTileApproved(),
          // ActivityTileInstantApproved()
        ],
      ),
    );
  }
}

class RatingBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    Future myratings() async {
      var box = Hive.box("icousel");
      var userid = box.get("userid");
      String blurl = "https://icounselgh.net/myrate";
      var response = await http.post(Uri.parse(blurl), body: {
        "userid": userid,
      });
      var result = jsonDecode(response.body);
      // // List<Mybooks> mbk = [];
      // // for (var u in result) {
      // //   Mybooks mm = Mybooks(
      // //       u['cname'], u['clocation'], u['ctype'], u['appdate'], u['apptime']);
      // //   mbk.add(mm);
      // }

      return result;
    }

    var nono = "";

    // openwhatsapp(String hisnumber) async {
    //   var whatsapp = "+233204200444";
    //   var whatsappURl_android =
    //       "whatsapp://send?phone=" + hisnumber + "&text=hello";
    //   var whatappURL_ios = "https://wa.me/$hisnumber?text=${Uri.parse("hello")}";
    //   if (Platform.isIOS) {
    //     // for iOS phone only
    //     if (await canLaunch(whatappURL_ios)) {
    //       await launch(whatappURL_ios, forceSafariVC: false);
    //     } else {
    //      print("whatsapp not installed");
    //     }
    //   } else {
    //     // android , web
    //     if (await canLaunch(whatsappURl_android)) {
    //       await launch(whatsappURl_android);
    //     } else {
    //      print("Whatsapp not installed");
    //     }
    //   }
    // }

    openwhatsapp(String hisnumber) async {
      var whatsapp = hisnumber;
      var whatsappURl_android =
          "whatsapp://send?phone=" + whatsapp + "&text=hello";
      var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunch(whatappURL_ios)) {
          await launch(whatappURL_ios, forceSafariVC: false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: new Text("whatsapp no installed")));
        }
      } else {
        // android , web
        if (await canLaunch(whatsappURl_android)) {
          await launch(whatsappURl_android);
        } else {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
          await launch(whatsappURl_android);
        }
      }
    }

    return FutureBuilder(
        future: myratings(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("No comment yet"),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: screenheight * 0.12,
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        // color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            child: ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Theme.of(context).accentColor,
                              ),
                              title: Text(
                                snapshot.data[index]['uname'],
                                style: GoogleFonts.montserrat(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                snapshot.data[index]['general'],
                                style: GoogleFonts.montserrat(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              // trailing: Text(snapshot.data[index]['date']),
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Mnotify()));
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
              },
            );
          }
        });
  }
}

class ActivityTileInstant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        width: double.infinity - 40,
        height: screenheight * 0.25,
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(0, 5), color: Colors.grey[200], blurRadius: 10),
        ], borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Row(children: [
          Column(children: [
            Container(
                height: 85,
                margin: EdgeInsets.only(left: 10, top: 10),
                width: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.cyan,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      //size: 40,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.data_usage,
                      //size: 40,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.person,
                      //size: 40,
                      color: Colors.white,
                    ),
                  ],
                )),
            Container(
              height: 40,
              width: 85,
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.only(left: 10, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[200],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "31 July, 2021",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "2:00 PM",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ]),
            )
          ]),
          SizedBox(width: 10),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("You will be assigned a counsellor shortly",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Text(
                  "Health Counsellor",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: Theme.of(context).accentColor,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text("Legon",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 35,
                          width: 95,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.greenAccent,
                          ),
                          child: Center(
                            child: Text("Pending",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 35,
                          width: 95,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.redAccent,
                          ),
                          child: Center(
                            child: Text("Cancel",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                          )),
                    )
                  ],
                )
              ])
        ]));
  }
}

class ActivityTileApproved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Stack(children: [
      Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          width: double.infinity - 40,
          height: screenheight * 0.25,
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), color: Colors.grey[200], blurRadius: 10),
          ], borderRadius: BorderRadius.circular(16), color: Colors.white),
          child: Row(children: [
            Column(children: [
              Container(
                  height: 85,
                  margin: EdgeInsets.only(left: 10, top: 10),
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.red,
                  ),
                  child: Icon(
                    Icons.date_range,
                    size: 40,
                    color: Colors.white,
                  )),
              Container(
                height: 40,
                width: 85,
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.only(left: 10, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[200],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "31 July, 2021",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "2:00 PM",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ]),
              )
            ]),
            SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hawa Adams",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Text(
                    "Health Counsellor",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: Theme.of(context).accentColor,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text("Legon",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: 35,
                            width: 85,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Theme.of(context).accentColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.call,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text("Call",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: 35,
                            width: 85,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey[300],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text("Chat",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                              ],
                            )),
                      )
                    ],
                  )
                ])
          ])),
      Positioned(
        right: 20,
        top: 10,
        child: Container(
            height: 20,
            width: 60,
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.only(left: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.greenAccent,
            ),
            child: Center(
              child: Text("Approved",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            )),
      )
    ]);
  }
}

class ActivityTileInstantApproved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Stack(children: [
      Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          width: double.infinity - 40,
          height: screenheight * 0.25,
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), color: Colors.grey[200], blurRadius: 10),
          ], borderRadius: BorderRadius.circular(16), color: Colors.white),
          child: Row(children: [
            Column(children: [
              Container(
                  height: 85,
                  margin: EdgeInsets.only(left: 10, top: 10),
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.cyan,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        //size: 40,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.data_usage,
                        //size: 40,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.person,
                        //size: 40,
                        color: Colors.white,
                      ),
                    ],
                  )),
              Container(
                height: 40,
                width: 85,
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.only(left: 10, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[200],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "31 July, 2021",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "2:00 PM",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ]),
              )
            ]),
            SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hawa Adams",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Text(
                    "Health Counsellor",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: Theme.of(context).accentColor,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text("Legon",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: 35,
                            width: 85,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Theme.of(context).accentColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.call,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text("Call",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: 35,
                            width: 85,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey[300],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text("Chat",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                              ],
                            )),
                      )
                    ],
                  )
                ])
          ])),
      Positioned(
        right: 20,
        top: 10,
        child: Container(
            height: 20,
            width: 60,
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.only(left: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.greenAccent,
            ),
            child: Center(
              child: Text("Approved",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            )),
      )
    ]);
  }
}

class Mybooks {
  final String cname;
  final String cloc;
  final String ctype;
  // final String cpic;
  final String cdate;
  final String ctime;

  Mybooks(this.cname, this.cloc, this.ctype, this.cdate, this.ctime);
}
