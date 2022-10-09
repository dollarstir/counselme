import 'package:flutter/material.dart';
import 'package:icounselgh/groups.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icounselgh/BookSection.dart';

class InstantSessionPage extends StatefulWidget {
  @override
  _InstantSessionPageState createState() => _InstantSessionPageState();
}

class _InstantSessionPageState extends State<InstantSessionPage> {
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  Future<void> _sms(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openwhatsapp() async {
    var whatsapp = "+233208496496";
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
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
        await launch(whatsappURl_android);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(350.0),
        child: Container(
          child: AppBar(
            // height: 80,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),

            title: Column(
              children: <Widget>[
                Text(
                  'Counselling',
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'Session',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                // Text(
                //   'This service helps to have direct counselling sessions with our counsellors at any time either via direct call, chat or SMS. You can also book a session at your convenience..',
                //   style: GoogleFonts.montserrat(
                //       fontSize: 10,
                //       fontWeight: FontWeight.w400,
                //       color: Colors.white),
                // ),
              ],
            ),
            bottom: PreferredSize(
              child: Container(
                // color: Colors.blue,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/circles.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                padding: EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child:Image(image:  AssetImage('assets/images/cs.png'),width: screenwidth * 0.3,)),
                    // SizedBox(height: 10),
                    Text(
                      'This service helps to have direct counselling sessions with our counsellors at any time either via direct call, chat or SMS. You can also book a session at your convenience.',
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                          textAlign: TextAlign.justify
                    ),
                    Text(
                      'Start a session now',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(100),
            ),
            backgroundColor: Color(0xfffaab3b),
            centerTitle: true,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: screenheight * 0.06,
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(left: 30, top: 10, right: 30),
                padding: EdgeInsets.all(2),
                width: 340,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          offset: Offset(0, 8),
                          color: Colors.grey[200],
                          blurRadius: 10),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //SizedBox(width: 30),
                    GestureDetector(
                      onTap: () async {
                        _makePhoneCall("tel:+233208496496");
                      },
                      child: Container(
                          height: 40,
                          width: 90,
                          padding: EdgeInsets.all(4),
                          // margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                      onTap: () async {
                        openwhatsapp();
                      },
                      child: Container(
                          height: 40,
                          width: 90,
                          padding: EdgeInsets.all(4),
                          // margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble,
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
                    ),

                    GestureDetector(
                      onTap: () async {
                         _sms("sms:+233208496496");
                      },
                      child: Container(
                          height: 40,
                          width: 90,
                          padding: EdgeInsets.all(4),
                          // margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.sms,
                                size: 15,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text("SMS",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                            ],
                          )),
                    ),

                    // SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: screenheight * 0.05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, //background color of button
                    // side: BorderSide(width:3, color:Colors.brown), //border width and color
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(10) //content padding inside button
                    ),
                onPressed: () {
                  Route route =
                      MaterialPageRoute(builder: (c) => Groups());
                  Navigator.push(context, route);
                },
                // textColor: Colors.white,
                // padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(7.0),
                  margin: const EdgeInsets.only(left:10,right:10),
                  child:  Text(
                    'Join Our Group Counselling Sessions',
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
              ),

              SizedBox(height: screenheight * 0.05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, //background color of button
                    // side: BorderSide(width:3, color:Colors.brown), //border width and color
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(10) //content padding inside button
                    ),
                onPressed: () {
                  Route route =
                      MaterialPageRoute(builder: (c) => BookSession());
                  Navigator.push(context, route);
                },
                // textColor: Colors.white,
                // padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(7.0),
                  child:  Text(
                    'Book for a session',
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
