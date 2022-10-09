import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:icounselgh/BookSection.dart';
import 'package:icounselgh/HomePage.dart';
import 'package:icounselgh/about.dart';
import 'package:icounselgh/activitybackup.dart';
import 'package:icounselgh/cform.dart';
import 'package:icounselgh/changePasswordPage.dart';
import 'package:icounselgh/ctest.dart';
import 'package:icounselgh/feedback.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'feedback.dart';

class Myprofile extends StatefulWidget {
  final String image;
  final String name;
  final String number;
  final String email;
  final String location;

  const Myprofile(
      {Key key, this.image, this.name, this.number, this.email, this.location})
      : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Myprofile> {
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
  var clientid;
  var udob;
  var box = Hive.box("icousel");
  var mid;

  @override
  void initState() {
    uname = box.get("uname");
    umail = box.get("umail");
    ucontact = box.get("ucontact");
    ucountry = box.get("ucountry");
    ugender = box.get("ugender");
    ustate = box.get("ustate");
    udob = box.get("udob");
    mid = box.get("userid");
    clientid  = "TCI" + mid.toString();

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

  openwhatsapp() async {
    var whatsapp = "+233244996991";
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text(
            "Your Details",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Center(
            child: Container(
              height: 120,
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Client ID :" + clientid ?? "Client ID :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        uname ?? "Nana Yaw",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        umail ?? "Cobby@gmail.com",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        ucontact ?? "+233556676471",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(ucountry ?? "Accra - Ghana",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 140),
              GestureDetector(
                  onTap: () {
                    update();
                  },
                  child: Text(
                    "Update Profile",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
          // Current(
          //   current: "Bookings",
          //   icon: Icons.person,
          //   tapped: () {
          //      Route route = MaterialPageRoute(builder: (c) => HomeScreen());
          //         Navigator.pushReplacement(context, route);
          //   },
          // ),

          Current(
            current: "Share App",
            icon: Icons.share,
            tapped: ()async{
             Share.share('https://play.google.com/store/apps/details?id=com.tuceehub.icounselgh', subject: 'Donwload iCounselGh App');
            },
          ),

          Current(
            current: "Counselling Consent form",
            icon: Icons.file_copy,
            tapped: () {
              Route route = MaterialPageRoute(builder: (c) => Cform());
              Navigator.push(context, route);
            },
          ),

          Current(
            current: "Make a Request",
            icon: Icons.sms,
            tapped: ()async{
                 Route route = MaterialPageRoute(builder: (c) => fdb());
              Navigator.push(context, route);

             
            },
          ),

          Current(
            current: "Logout",
            icon: Icons.logout,
            tapped: () {
              //
              // print(jj);
              // Route route = MaterialPageRoute(builder: (c) => LoginPage());
              // Navigator.pushReplacement(context, route);
               SweetAlert.show(context,
          subtitle: "Do you want to logout?",
          style: SweetAlertStyle.confirm,
          showCancelButton: true, onPress: (bool isConfirm) {
        if(isConfirm){
          SweetAlert.show(context,subtitle: "loging out...", style: SweetAlertStyle.loading);
           var box = Hive.box("icousel");
              box.put("islog", 0);
              var jj = box.get("islog");
          new Future.delayed(new Duration(seconds: 2),(){
            SweetAlert.show(context,subtitle: "Success!", style: SweetAlertStyle.success);
             Route route = MaterialPageRoute(builder: (c) => LoginPage());
              Navigator.pushReplacement(context, route);
          });
        }else{
          SweetAlert.show(context,subtitle: "Canceled!", style: SweetAlertStyle.error);
        }
        // return false to keep dialog
        return false;
      });

            },
          ),
          // Currentdel(
          //   current: "Delect Account",
          //   icon: Icons.delete,
          // ),
        ],
      ),
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
