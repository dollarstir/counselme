import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:icounselgh/BookSection.dart';
import 'package:icounselgh/about.dart';
import 'package:icounselgh/appinfo.dart';
import 'package:icounselgh/cform.dart';
import 'package:icounselgh/changePasswordPage.dart';
import 'package:icounselgh/ctest.dart';
import 'package:icounselgh/instantSession.dart';
import 'package:icounselgh/loginPage.dart';
import 'package:icounselgh/policy.dart';
import 'package:icounselgh/quotePage.dart';
import 'package:icounselgh/updateProfilePage.dart';

import 'faq.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class Settings extends StatefulWidget {
  final String image;
  final String name;
  final String number;
  final String email;
  final String location;

  const Settings(
      {Key key, this.image, this.name, this.number, this.email, this.location})
      : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void update() {
    Route route = MaterialPageRoute(builder: (c) => UpdateProfile());
    Navigator.push(context, route);
  }

  Future user() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    var userlink = "https://icounselgh.net/user";
    var response = await http.post(
      Uri.parse(userlink),
      body: {'userid': userid},
    );
    var result = jsonDecode(response.body);
    return result;
  }

  var uname;
  var umail;
  var ucontact;
  var ucountry;
  var ugender;
  var ustate;
  var udob;
  var box = Hive.box("icousel");

  @override
  void initState() {
    uname = box.get("uname");
    umail = box.get("umail");
    ucontact = box.get("ucontact");
    ucountry = box.get("ucountry");
    ugender = box.get("ugender");
    ustate = box.get("ustate");
    udob = box.get("udob");

    super.initState();
  }

  //  Function changePassword(){
  //   Route route = MaterialPageRoute(builder: (c) => ChangePassword());
  //               Navigator.push(context, route);
  // }


  Future ptest() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    var userlink = "https://icounselgh.net/ptest";
    var response = await http.post(
      Uri.parse(userlink),
      body: {'id': userid},
    );
    var result = jsonDecode(response.body);
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 5),
        // Text(
        //   "Settings",
        //   style: TextStyle(fontWeight: FontWeight.w500),
        // ),
        
        
        

        Current(
          current: "App Info",
          icon: Icons.file_copy,
          tapped: (){
             Route route = MaterialPageRoute(builder: (c) => AboutApp());
        Navigator.push(context, route);
          },
        ),

        // Current(
        //   current: "TUPSU",
        //   icon: Icons.file_copy,
        //   tapped: (){
        //      Route route = MaterialPageRoute(builder: (c) => QuoteScreen());
        // Navigator.push(context, route);
        //   },
        // ),

        // Current(
        //   current: "Book A Session",
        //   icon: Icons.folder_open,
        //   tapped: (){
        //      Route route = MaterialPageRoute(builder: (c) => BookSession());
        // Navigator.push(context, route);
        //   },
        // ),

        // Current(
        //   current: "Start Instant session",
        //   icon: Icons.refresh,
        //   tapped: (){
        //      Route route = MaterialPageRoute(builder: (c) => InstantSessionPage());
        // Navigator.push(context, route);
        //   },
        // ),

        // Current(
        //   current: "iDiscover-me",
        //   icon: Icons.text_snippet,
        //   tapped: ()async{
        //     SweetAlert.show(context,
        //           title: "Loading ..",
        //           subtitle: "Please wait...",
        //           style: SweetAlertStyle.loading,
        //           );

        //            var repo = await ptest();

        //            print(repo);

        //            if(repo == "pending"){
        //              SweetAlert.show(
        //               context,
        //               title: "Welcome!",
        //               subtitle: "Your request is under review",
        //               style: SweetAlertStyle.error,
        //             );

        //            }
        //            else if(repo == "approved"){
        //               Navigator.of(context).pop();
        //               Route route =
        //               MaterialPageRoute(builder: (c) => Ctest());
        //           Navigator.push(context, route);

        //            }
        //            else if(repo == "sent"){
        //               SweetAlert.show(context,
        //             title: "Congrats!!",
        //             subtitle: 'Your request is being proccessed',
        //             style: SweetAlertStyle.success,
        //             );

        //            }
        //            else if(repo == "failed"){


        //            }
        //   },
        // ),
        CurrentPass(
          current: "Password",
          icon: Icons.lock,
          //tapped: changePassword(),
        ),

        Current(
          current: "App Security",
          icon: Icons.security,
          tapped: (){
             Route route = MaterialPageRoute(builder: (c) => About());
        Navigator.push(context, route);
          },
        ),

        
        CurrentExpanded(
          current: "Frequentlty Asked Questions (FAQs)",
          icon: Icons.question_answer,
        ),
        Current(
          current: "Terms & Conditions",
          icon: Icons.security,
          tapped: (){
             Route route = MaterialPageRoute(builder: (c) => Tanc());
        Navigator.push(context, route);
          },
        ),
        // Current(
        //   current: "Logout",
        //   icon: Icons.logout,
        //   tapped: () {
        //     var box = Hive.box("icousel");
        //     box.put("islog", 0);
        //     var jj = box.get("islog");
        //     print(jj);
        //     Route route = MaterialPageRoute(builder: (c) => LoginPage());
        //     Navigator.pushReplacement(context, route);
        //   },
        // ),
        // Currentdel(
        //   current: "Delect Account",
        //   icon: Icons.delete,
        // ),
      ],),
    );
  }
}

class Current extends StatelessWidget {
  final Function tapped;
  final IconData icon;
  final String current;

  const Current({Key key, this.current, this.tapped, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapped,
      child: Container(
          height: 65,
          // padding: EdgeInsets.only(left: 10, right: 10),
          width: double.infinity,
          margin: EdgeInsets.only(top: 3, left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1), color: Colors.white),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(width: 5),
            Icon(this.icon ?? Icons.search, color: Colors.grey[500]),
            SizedBox(width: 23),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                      this.current,
                      style: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold),
                    ) ??
                    Text("Tap")),
            Expanded(
              child: Container(),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[500],
            )
          ])),
    );
  }
}

class CurrentExpanded extends StatelessWidget {
  final Function tapped;
  final IconData icon;
  final String current;

  const CurrentExpanded({Key key, this.current, this.tapped, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Route route = MaterialPageRoute(builder: (c) => Faq());
        Navigator.push(context, route);
      },
      child: Container(
          height: 65,
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 3,
            left: 10,
            right: 10,
            bottom: 3,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1), color: Colors.white),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(width: 5),
            Icon(this.icon ?? Icons.search, color: Colors.grey[500]),
            SizedBox(width: 23),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                      this.current,
                      style: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold),
                    ) ??
                    Text("Tap")),
            Expanded(
              child: Container(),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[500],
            )
          ])),
    );
  }
}

class Currentdel extends StatelessWidget {
  final Function tapped;
  final IconData icon;
  final String current;

  const Currentdel({Key key, this.current, this.tapped, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapped,
      child: Container(
          height: 65,
          width: double.infinity,
          margin: EdgeInsets.only(top: 3, left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1), color: Colors.white),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(width: 5),
            Icon(this.icon ?? Icons.search, color: Colors.red),
            SizedBox(width: 23),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                      this.current,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ) ??
                    Text("Tap")),
            Expanded(
              child: Container(),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            )
          ])),
    );
  }
}

class CurrentPass extends StatelessWidget {
  //final Function tapped;
  final IconData icon;
  final String current;

  const CurrentPass({Key key, this.current, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Route route = MaterialPageRoute(builder: (c) => ChangePassword());
        Navigator.push(context, route);
      },
      child: Container(
          height: 65,
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 3,
            left: 10,
            right: 10,
            bottom: 3,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1), color: Colors.white),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(width: 5),
            Icon(this.icon ?? Icons.search, color: Colors.grey[500]),
            SizedBox(width: 23),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                      this.current,
                      style: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold),
                    ) ??
                    Text("Tap")),
            Expanded(
              child: Container(),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[500],
            )
          ])),
    );
  }
}
