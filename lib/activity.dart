import 'dart:convert';
import 'dart:io';
import 'dart:async';

import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:icounselgh/HomePage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:google_fonts/google_fonts.dart';

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: ActivityTile()),
      // ActivityTileInstant(),
      // ActivityTileApproved(),
      // ActivityTileInstantApproved()
    ]);
  }
}

class ActivityTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    Future myBookings() async {
      var box = Hive.box("icousel");
      var userid = box.get("userid");
      String blurl = "https://icounselgh.net/bookings";
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

    Future cancel(var hisid) async {
      var box = Hive.box("icousel");
      var userid = box.get("userid");
      String blurl = "https://icounselgh.net/cancel";
      var response = await http.post(Uri.parse(blurl), body: {
        "id": hisid.toString(),
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

    Future<void> _makePhoneCall(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
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

    void cancelbooking(mydata)async{
      SweetAlert.show(
                                      context,
                                      title: "Loading ..",
                                      subtitle: "Please wait...",
                                      style: SweetAlertStyle.loading,
                                    );
                                    var resp = await cancel(mydata);

                                    if (resp == "failed") {
                                      // Navigator.of(context).pop();
                                      SweetAlert.show(
                                        context,
                                        title: "Sorry",
                                        subtitle: "Faild to cancel",
                                        style: SweetAlertStyle.error,
                                      );
                                    } else if (resp == "delected") {
                                      SweetAlert.show(
                                        context,
                                        title: "Congrats!!",
                                        subtitle: 'Booking Cancelled',
                                        style: SweetAlertStyle.success,
                                      );

                                      Future.delayed(Duration(seconds: 3), () {
                                        //Navigator.of(context).pop();
                                        Route route = MaterialPageRoute(
                                            builder: (c) => HomeScreen());
                                        Navigator.pushReplacement(
                                            context, route);
                                      });
                                    } else {
                                      SweetAlert.show(
                                        context,
                                        title: 'Sorry',
                                        subtitle:
                                            'something wneth wrong try again',
                                        style: SweetAlertStyle.error,
                                      );
                                    }
    }


    void cancelbooking2(mydata)async{
      SweetAlert.show(
                                        context,
                                        title: "Loading ..",
                                        subtitle: "Please wait...",
                                        style: SweetAlertStyle.loading,
                                      );
                                      var resp = await cancel(mydata);

                                      if (resp == "failed") {
                                        // Navigator.of(context).pop();
                                        SweetAlert.show(
                                          context,
                                          title: "Sorry",
                                          subtitle: "Faild to cancel",
                                          style: SweetAlertStyle.error,
                                        );
                                      } else if (resp == "delected") {
                                        SweetAlert.show(
                                          context,
                                          title: "Congrats!!",
                                          subtitle: 'Booking Cancelled',
                                          style: SweetAlertStyle.success,
                                        );

                                        Future.delayed(Duration(seconds: 3),
                                            () {
                                          //Navigator.of(context).pop();
                                          Route route = MaterialPageRoute(
                                              builder: (c) => HomeScreen());
                                          Navigator.pushReplacement(
                                              context, route);
                                        });
                                      } else {
                                        SweetAlert.show(
                                          context,
                                          title: 'Sorry',
                                          subtitle:
                                              'something wneth wrong try again',
                                          style: SweetAlertStyle.error,
                                        );
                                      }
    }

    return FutureBuilder(
        future: myBookings(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("No activity"),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (BuildContext context, int index) {
                String dd = snapshot.data[index]["appdate"];
                var mdt = dd.split(',');
                String newd = mdt[1] + "," + mdt[2];
                String newName = snapshot.data[index]["ctype"];
                newName = newName.replaceAll('counsellor', ' ');
                print(newName);

                ;
                //  var newd2 = newd.split(', ');
                String newdate = newd;
                if (snapshot.data[index]["status"] == "pending" &&
                    snapshot.data[index]["cid"] == "notyet") {
                  return Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    width: double.infinity - 40,
                    height: screenheight * 0.27,
                    decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              offset: Offset(0, 5),
                              color: Colors.grey[200],
                              blurRadius: 10),
                        ],
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Column(children: [
                          Container(
                              height: 80,
                              margin: EdgeInsets.only(left: 10, top: 10),
                              width: 85,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.red,
                              ),
                              child: Icon(
                                Icons.date_range,
                                size: 40,
                                color: Colors.white,
                              )),
                          Container(
                            height: 45,
                            width: 85,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.grey[200],
                            ),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    newdate,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    snapshot.data[index]["apptime"],
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
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
                                style:  GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      )),
                            Text(
                              snapshot.data[index]["ctype"],
                              style:GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xfffaab3b),
                                  ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.place,
                                  color: Theme.of(context).accentColor,
                                  size: 15,
                                ),
                                SizedBox(width: 5),
                                Text(snapshot.data[index]["clocation"],
                                    style:  GoogleFonts.montserrat(
                      fontSize: 13, fontWeight: FontWeight.w600,color:Colors.black,)),
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
                                      margin:
                                          EdgeInsets.only(left: 10, top: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                                  onTap: () async {
                                    // do something
                                    // cancelbooking(snapshot.data[index]["id"]);
                                    SweetAlert.show(context,
                              subtitle:
                                  "\t\t\t Do you want to cancel your booking?",
                              style: SweetAlertStyle.confirm,
                              showCancelButton: true,
                              onPress: (bool isConfirm) {
                            if (isConfirm) {
                              cancelbooking(snapshot.data[index]["id"]);
                            } else {
                              // SweetAlert.show(context,
                              //     subtitle: "Canceled!",
                              //     style: SweetAlertStyle.error);
                              Navigator.of(context).pop();
                            }
                            // return false to keep dialog
                            return false;
                          });
                        
                                  },
                                  child: Container(
                                      height: 35,
                                      width: 95,
                                      padding: EdgeInsets.all(4),
                                      margin:
                                          EdgeInsets.only(left: 10, top: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.data[index]["status"] == "pending" &&
                    snapshot.data[index]['cid'] != "") {
                  return Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    width: double.infinity - 40,
                    height: screenheight * 0.27,
                    decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              offset: Offset(0, 5),
                              color: Colors.grey[200],
                              blurRadius: 10),
                        ],
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Column(children: [
                          Container(
                            height: 85,
                            margin: EdgeInsets.only(left: 10, top: 10),
                            width: 85,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              // color: Colors.red,
                            ),
                            child: Image(
                              image: NetworkImage(
                                  "https://icounselgh.net/main/default/upload/${snapshot.data[index]["cpic"]}"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 85,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.grey[200],
                            ),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    newdate,
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    snapshot.data[index]["apptime"],
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ]),
                          )
                        ]),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data[index]["cname"],
                                  style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      )),
                              Text(newName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xfffaab3b),
                                  )),
                              Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    color: Theme.of(context).accentColor,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    snapshot.data[index]["clocation"],
                                    style: GoogleFonts.montserrat(
                      fontSize: 13, fontWeight: FontWeight.w600,color:Colors.black,)
                                  ),
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
                                        margin:
                                            EdgeInsets.only(left: 10, top: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                                    onTap: () async {
                                      // do something 2
                                      // cancelbooking2(snapshot.data[index]["id"]);
                                      SweetAlert.show(context,
                              subtitle:
                                  "\t\t\t Do you want to cancel your booking?",
                              style: SweetAlertStyle.confirm,
                              showCancelButton: true,
                              onPress: (bool isConfirm) {
                            if (isConfirm) {
                              cancelbooking2(snapshot.data[index]["id"]);
                            } else {
                              // SweetAlert.show(context,
                              //     subtitle: "Canceled!",
                              //     style: SweetAlertStyle.error);
                              Navigator.of(context).pop();
                            }
                            // return false to keep dialog
                            return false;
                          });

                                    },
                                    child: Container(
                                        height: 35,
                                        width: 95,
                                        padding: EdgeInsets.all(4),
                                        margin:
                                            EdgeInsets.only(left: 10, top: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.data[index]['status'] == "approved") {
                  return Stack(children: [
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        width: double.infinity - 40,
                        height: screenheight * 0.27,
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  color: Colors.grey[200],
                                  blurRadius: 10),
                            ],
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        child: Row(children: [
                          Column(children: [
                            Container(
                              height: 85,
                              margin: EdgeInsets.only(left: 10, top: 10),
                              width: 85,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                // color: Colors.red,
                              ),
                              child: Image(
                                image: NetworkImage(
                                    "https://icounselgh.net/main/default/upload/${snapshot.data[index]["cpic"]}"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 85,
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.only(left: 10, top: 10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey[200],
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      newdate,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      snapshot.data[index]["apptime"],
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ]),
                            )
                          ]),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data[index]["cname"],
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Text(newName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xfffaab3b),
                                      )),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.place,
                                        color: Theme.of(context).accentColor,
                                        size: 15,
                                      ),
                                      SizedBox(width: 5),
                                      Text(snapshot.data[index]["clocation"],
                                          style:  GoogleFonts.montserrat(
                      fontSize: 13, fontWeight: FontWeight.w600,color:Colors.black,),),
                                    ],
                                  ),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () async {
                                          _makePhoneCall(
                                              "tel:+233${snapshot.data[index]["ccontact"]}");
                                        },
                                        child: Container(
                                            height: 35,
                                            width: 85,
                                            padding: EdgeInsets.all(4),
                                            margin: EdgeInsets.only(
                                                left: 10, top: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            )),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          print(
                                              snapshot.data[index]["ccontact"]);
                                          var nn;
                                          openwhatsapp(
                                              "233${snapshot.data[index]["ccontact"]}");
                                        },
                                        child: Container(
                                            height: 35,
                                            width: 85,
                                            padding: EdgeInsets.all(4),
                                            margin: EdgeInsets.only(
                                                left: 10, top: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Colors.grey[300],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            )),
                                      )

                                      //                       ElevatedButton(
                                      //   onPressed: () {
                                      //   _makePhoneCall("tel:+233556676471");
                                      //     // _makePhoneCall("tel:" + snapshot.data[index]["contact"].toString());
                                      //   },
                                      //   child: const Text('Make phone call'),
                                      // ),
                                    ],
                                  )
                                ]),
                          )
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
