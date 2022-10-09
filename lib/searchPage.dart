//import 'dart:ffi';
import 'dart:async';
import 'dart:convert';
//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:icounselgh/HomePage.dart';
import 'package:icounselgh/cform.dart';
import 'package:icounselgh/counsellorProfilePage.dart';

import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenheight * 0.01),
          // Center(child: Icon(Icons.search, size: 80,  color: Colors.grey[300],)),
          // Text("Search for counsellor\nyou already know of", style: TextStyle(color: Colors.grey[400]),)
          Expanded(child: CounsellorTile1()),
        ]);
  }
}

class CounsellorTile1 extends StatelessWidget {
  var cid;
  String name;
  String type;
  String location;
  String image;

  CounsellorTile1({this.cid, this.name, this.type, this.location, this.image});
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    Future<List<Counsellor>> Getcounsellor1() async {
      var rl = "https://icounselgh.net/cc";
      var resp = await http.get(
        Uri.parse(rl),
        headers: {"Accept": "application/json"},
      );
      var decoded = jsonDecode(resp.body);
      //  return decoded;
      //  print(decoded);
      List<Counsellor> couns1 = [];
      for (var c in decoded) {
        Counsellor cc = Counsellor(c['id'], c['name'], c['email'], c['contact'],
            c['region'], c['type'],c['cgroup'],c['gpcpin'], c['status'], c['pic'],c['bio']);
        couns1.add(cc);
      }
      // print(couns.length);
      return couns1;
    }

     Future cftest() async {
      var box = Hive.box("icousel");
      var userid = box.get("userid");
      var userlink = "https://icounselgh.net/cftest";
      var response = await http.post(
        Uri.parse(userlink),
        body: {'id': userid},
      );
      var result = jsonDecode(response.body);
      return result;
    }

    return Container(
      child: StreamBuilder(
        stream: Hive.box("icousel").watch(),
        builder: (context, data) => FutureBuilder(
            future: Getcounsellor1(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("No result found..."),
                  ),
                );
              } else {
                List<Counsellor> counsellorm = snapshot.data;

                counsellorm = counsellorm.where((element) {
                  String loc = Hive.box("icousel").get("counsellor_location");
                  String cat = Hive.box("icousel").get("counsellor_category");
                  String name = Hive.box("icousel").get("counsellor_name");

                  if (cat == "All Categories") {
                    cat = "";
                  }
                  //if (cat != "") {
                  //  cat = "$cat counsellor";
                  //}

                  // print("----------------");
                  // print("${element.cstate} -- $loc");
                  // print("${element.ctype} -- $cat");

                  return element.cstate.contains(loc) &&
                      element.ctype.contains(cat) && element.cname.toLowerCase().contains(name);
                }).toList();

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: counsellorm.length,
                    itemBuilder: (BuildContext context, int index) {
                      String newName = counsellorm[index].ctype;
                      newName = newName.replaceAll('counsellor', ' ');
                      return Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        width: double.infinity - 40,
                        height: screenheight * 0.2,
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.19,

                            //height: 500,
                            margin: EdgeInsets.symmetric(horizontal: 3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image(
                                image: NetworkImage(
                                    "https://icounselgh.net/main/default/upload/${counsellorm[index].pic}" ??
                                        "assets/images/counsellor1.jpeg"),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          counsellorm[index].cname ??
                                              "Counsellor",
                                             
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                            newName ??
                                                "Good Counsellor",
                                                 maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              //softWrap: true,
                                            style: TextStyle(
                                                color:
                                                    Theme.of(context).accentColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.place,
                                              color:
                                                  Theme.of(context).accentColor,
                                              size: 15,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                                counsellorm[index].cstate ??
                                                    "Legon",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 111,
                                      ),
                                      GestureDetector(
                                        onTap: ()async{
                                          // Route route = MaterialPageRoute(
                                          //     builder: (c) => BookCounsellor(
                                          //         data: counsellorm[index]));
                                          // Navigator.push(context, route);

                                          SweetAlert.show(
                                            context,
                                            title: "Loading ..",
                                            subtitle: "Please wait...",
                                            style: SweetAlertStyle.loading,
                                          );

                                          var repo = await cftest();

                                          print(repo);

                                          if (repo == "new") {
                                            // SweetAlert.show(
                                            //   context,
                                            //   title: "Warning",
                                            //   subtitle:
                                            //       "   Kindly Navigate to settings to fill Counselling Consent form before  before ",
                                            //   style: SweetAlertStyle.error,
                                            // );

                                            SweetAlert.show(context,
                                                subtitle:
                                                    "Hello!, Kindly complete the consent form to start booking",
                                                style: SweetAlertStyle.confirm,
                                                showCancelButton: true,
                                                onPress: (bool isConfirm) {
                                              if (isConfirm) {
                                                SweetAlert.show(context,
                                                    subtitle: "loading...",
                                                    style:
                                                        SweetAlertStyle.loading);
                                                new Future.delayed(
                                                    new Duration(seconds: 2), () {
                                                       Navigator.of(context).pop();
                                                  Route route = MaterialPageRoute(
                                                      builder: (c) => Cform());
                                                  Navigator.push(context, route);
                                                });
                                              } else {
                                                SweetAlert.show(context,
                                                    subtitle: "Canceled!",
                                                    style: SweetAlertStyle.error);
                                              }
                                              // return false to keep dialog
                                              return false;
                                            });
                                          } else if (repo == "done") {
                                            Navigator.of(context).pop();
                                            Route route = MaterialPageRoute(
                                                builder: (c) => BookCounsellor(
                                                    data: counsellorm[index]));
                                            Navigator.push(context, route);
                                          } else {
                                            SweetAlert.show(
                                              context,
                                              title: "Warning",
                                              subtitle:
                                                  "   Kindly check your internet connection and try again",
                                              style: SweetAlertStyle.error,
                                            );
                                          }
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            height: 40,
                                            width: 100,
                                            child: Center(
                                                child: Text(
                                              "Book",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).accentColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                      );
                    });
              }
            }),
      ),
    );
  }
}

// class Counsellor {
//   final int cid;
//   final String cname;
//   final String cmail;
//   final int ccontact;
//   final String cstate;
//   final String ctype;
//   final String cstatus;
//   final String pic;
//   // final String dateadded;
//   Counsellor(this.cid, this.cname, this.cmail, this.ccontact, this.cstate,
//       this.ctype, this.cstatus,this.pic);
// }
