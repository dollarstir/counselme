import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icounselgh/newcounsellor.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:modern_form_esys_flutter_share/modern_form_esys_flutter_share.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class Cregister extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<Cregister> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenheight * 0.1),
        child: AppBar(
          // height: 80,
          elevation: 0,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(30),
          //   ),
          // ),

          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Counsellor',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'registration',
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xfffaab3b)),
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
          // bottom: PreferredSize(
          //   child: Container(
          //     // color: Colors.blue,
          //     padding: EdgeInsets.only(top:20, right: 20,left:20),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           'The iDiscover-me services use a well-designed,validated and reliable Personality Psychometric Test to help you idenetify your interest, ability and personality type. The result will help you to make informed decision about academic programme, relationship, marriage, career and more.',
          //           style: GoogleFonts.montserrat(
          //               fontSize: 12,
          //               fontWeight: FontWeight.w400,
          //               color: Colors.black),
          //         ),
          //         Text(
          //           'Discover your true self now',
          //           style: GoogleFonts.montserrat(
          //             fontSize: 12,
          //             fontWeight: FontWeight.bold,
          //             color: Color(0xfffaab3b),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   preferredSize: Size.fromHeight(10),
          // ),
          backgroundColor: Color(0xfffff),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Stack(
          // height:screenheight,

          children: [
            //  SizedBox(width: screenwidth, height: screenheight),
            Positioned(
              //  top :0,
              // bottom: 0,
              // left: 0,
              // right:0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      //  color: Colors.blue,
                    ),
                    width: screenwidth,
                    height: screenheight * 0.30,
                    child: Container(
                      // color: Colors.blue,
                      padding: EdgeInsets.only(top: 1, right: 20, left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Container(child:Image(image:  AssetImage('assets/images/creg.png'),width: screenwidth * 0.3,)),
                          Text(
                            'Congratulations',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xfffaab3b),
                            ),
                          ),
                          Text(
                            'for taking the counselling profession. Do you want to be connected to clients anywhere and anytime?  Then join the iCounsel-Gh team.',
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: screenheight * 0.562,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/circles.png'),
                    fit: BoxFit.fill,
                  ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Color(0xfffaab3b),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: screenheight * .095,
              left: screenwidth * 0.05,
              right: screenwidth * 0.05,
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      Center(
                        child: Text(
                          "Requirements",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    SizedBox(height: 25),
                       Container(
                        child: Text(
                          "You must be a:",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 35),

                      new ListTile(
                              leading: new MyBullet(),
                              title: new Text('trained and licensed  Counsellor or Psychologist',
                              style : GoogleFonts.montserrat(
                                    fontSize: 15, fontWeight: FontWeight.w600,color: Colors.white),
                              ),
                            ),
                            new ListTile(
                              leading: new MyBullet(),
                              title: new Text('member of a professional association of Counsellors or Psychologists',
                              style: GoogleFonts.montserrat(
                                    fontSize: 15, fontWeight: FontWeight.w600,color: Colors.white),
                              ),
                            ),

                            new ListTile(
                              leading: new MyBullet(),
                              title: new Text('trained Cyber Counselling Practitioner',
                              style: GoogleFonts.montserrat(
                                    fontSize: 15, fontWeight: FontWeight.w600,color: Colors.white),
                              ),
                            ),

                            SizedBox(height: 45),

                            Center(
                              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, //background color of button
                    // side: BorderSide(width:3, color:Colors.brown), //border width and color
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(8) //content padding inside button
                    ),
                onPressed: () {
                  Route route =
                      MaterialPageRoute(builder: (c) => NewCounsellor());
                  Navigator.push(context, route);
                },
                // textColor: Colors.white,
                // padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child:  Text(
                    'Register',
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
              ),
                            ),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(25),
                      //   child: _homeCard(
                      //     context,
                      //     height: screenheight,
                      //     width: screenwidth,
                      //     image: 'assets/images/ccon.png',
                      //     onTap: () {
                      //       // Route route =
                      //       //     MaterialPageRoute(builder: (c) => QuoteScreen());
                      //       // Navigator.push(context, route);
                      //     },
                      //   ),
                      // ),
                      //  SizedBox(width: screenwidth * 0.05,),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(25),
                      //   child: _homeCard(
                      //     context,
                      //     height: screenheight,
                      //     width: screenwidth,
                      //     image: 'assets/images/ttalk.png',
                      //     onTap: () {
                      //       // Route route =
                      //       //     MaterialPageRoute(builder: (c) => QuoteScreen());
                      //       // Navigator.push(context, route);
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _homeCard(
    BuildContext context, {
    double height,
    double width,
    Function onTap,
    String image,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 15,
        child: Container(
          padding: EdgeInsets.all(5),
          height: height * 0.13,
          margin: EdgeInsets.only(left: 10, top: 10),
          width: width * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.white,
          ),
          // child: Image(
          //   image: AssetImage(
          //       "assets/images/gt.png"),
          //   // fit: BoxFit.cover,
          //   alignment: Alignment.topCenter,
          // ),
        ),
      ),
    );
  }
}

class QuoteTile extends StatelessWidget {
  @override

  // Future<void> _shareImageFromUrl() async {
  //   try {
  //     var request = await HttpClient().getUrl(Uri.parse(
  //         'https://shop.esys.eu/media/image/6f/8f/af/amlog_transport-berwachung.jpg'));
  //     var response = await request.close();
  //     Uint8List bytes = await consolidateHttpClientResponseBytes(response);
  //     await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
  //   } catch (e) {
  //     print('error: $e');
  //   }
  // }
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    Future mnoti() async {
      var box = Hive.box("icousel");
      var userid = box.get("userid");
      String blurl = "https://icounselgh.net/mnotify";
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

    // futre
    return FutureBuilder(
        future: mnoti(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("No notification yet"),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (BuildContext context, int index) {
                return Container(
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
                                Icons.notifications,
                                color: Theme.of(context).accentColor,
                              ),
                              // title: Text(snapshot.data[index]['nmess']),
                              subtitle: Text(
                                snapshot.data[index]['nmess'],
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
class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height:7.0,
      width:7.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
