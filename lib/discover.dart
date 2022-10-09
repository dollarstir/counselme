import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icounselgh/ctest.dart';
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
import 'package:sweetalert/sweetalert.dart';

class Discover extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<Discover> {
  var mypcat;

  Future ptest(String pcat) async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    var userlink = "https://icounselgh.net/ptest";
    var response = await http.post(
      Uri.parse(userlink),
      body: {
        'id': userid,
        'pcat': pcat,
      },
    );
    var result = jsonDecode(response.body);
    return result;
  }

  void myCall() async {
    setState(() {
      mypcat = "career identification";
    });
    SweetAlert.show(
      context,
      title: "Loading ..",
      subtitle: "Please wait...",
      style: SweetAlertStyle.loading,
    );

    var repo = await ptest(mypcat);

    print(repo);

    if (repo == "pending") {
      SweetAlert.show(
        context,
        title: "Welcome!",
        subtitle: "Your request is under review",
        style: SweetAlertStyle.error,
      );
    } else if (repo == "approved") {
      Navigator.of(context).pop();
      Route route = MaterialPageRoute(builder: (c) => Ctest());
      Navigator.push(context, route);
    } else if (repo == "sent") {
      SweetAlert.show(
        context,
        title: "Congrats!!",
        subtitle: 'Your request is being proccessed',
        style: SweetAlertStyle.success,
      );
    } else if (repo == "failed") {}
  }

  void myCall1() async {
    setState(() {
      mypcat = "marital compatibility";
    });
    SweetAlert.show(
      context,
      title: "Loading ..",
      subtitle: "Please wait...",
      style: SweetAlertStyle.loading,
    );

    var repo = await ptest(mypcat);

    print(repo);

    if (repo == "pending") {
      SweetAlert.show(
        context,
        title: "Welcome!",
        subtitle: "Your request is under review",
        style: SweetAlertStyle.error,
      );
    } else if (repo == "approved") {
      Navigator.of(context).pop();
      Route route = MaterialPageRoute(builder: (c) => Ctest());
      Navigator.push(context, route);
    } else if (repo == "sent") {
      SweetAlert.show(
        context,
        title: "Congrats!!",
        subtitle: 'Your request is being proccessed',
        style: SweetAlertStyle.success,
      );
    } else if (repo == "failed") {}
  }

  void myCall2()async{
    setState(() {
                            mypcat = "Academic Programme";
                          });
                          SweetAlert.show(
                            context,
                            title: "Loading ..",
                            subtitle: "Please wait...",
                            style: SweetAlertStyle.loading,
                          );

                          var repo = await ptest(mypcat);

                          print(repo);

                          if (repo == "pending") {
                            SweetAlert.show(
                              context,
                              title: "Welcome!",
                              subtitle: "Your request is under review",
                              style: SweetAlertStyle.error,
                            );
                          } else if (repo == "approved") {
                            Navigator.of(context).pop();
                            Route route =
                                MaterialPageRoute(builder: (c) => Ctest());
                            Navigator.push(context, route);
                          } else if (repo == "sent") {
                            SweetAlert.show(
                              context,
                              title: "Congrats!!",
                              subtitle: 'Your request is being proccessed',
                              style: SweetAlertStyle.success,
                            );
                          } else if (repo == "failed") {}
  }

  void myCall3() async {
    setState(() {
                            mypcat = "Personal Ability";
                          });
                          SweetAlert.show(
                            context,
                            title: "Loading ..",
                            subtitle: "Please wait...",
                            style: SweetAlertStyle.loading,
                          );

                          var repo = await ptest(mypcat);

                          print(repo);

                          if (repo == "pending") {
                            SweetAlert.show(
                              context,
                              title: "Welcome!",
                              subtitle: "Your request is under review",
                              style: SweetAlertStyle.error,
                            );
                          } else if (repo == "approved") {
                            Navigator.of(context).pop();
                            Route route =
                                MaterialPageRoute(builder: (c) => Ctest());
                            Navigator.push(context, route);
                          } else if (repo == "sent") {
                            SweetAlert.show(
                              context,
                              title: "Congrats!!",
                              subtitle: 'Your request is being proccessed',
                              style: SweetAlertStyle.success,
                            );
                          } else if (repo == "failed") {}
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenheight * 0.08),
        child: AppBar(
          // height: 80,
          elevation: 0,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(30),
          //   ),
          // ),

          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'iDiscover -',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: 10),
              Text(
                'Me',
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
                    height: screenheight * 0.363,
                    child: Container(
                      // color: Colors.blue,
                      padding: EdgeInsets.only(top: 2, right: 40, left: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Container(child:Image(image:  AssetImage('assets/images/idis.png'),width: screenwidth * 0.3,)),
                          Text(
                            'The iDiscover-me services use a well-designed,validated and reliable Personality Psychometric Test to help you identify your interest, ability and personality type. The results will help you make informed decision on your academic programme, relationship, marriage, career and more.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Text(
                            'Discover your true self now',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xfffaab3b),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: screenheight * 0.52,
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
              bottom: screenheight * .1,
              left: screenwidth * 0.05,
              right: screenwidth * 0.05,
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      _homeCard(
                        context,
                        height: screenheight,
                        width: screenwidth,
                        image: 'assets/images/cid.png',
                        onTap: () async {
                          //
                          SweetAlert.show(context,
                              subtitle:
                                  "\t\t\tGet to know your strengths,\n\t\t\tweaknesses, opportunities and\n\t\t\tthreats in terms of your career\n\t\t\tpath. Take the test to find out\n\t\t\tthe best career for your life.",
                              style: SweetAlertStyle.confirm,
                              showCancelButton: true,
                              onPress: (bool isConfirm) {
                            if (isConfirm) {
                              myCall();
                            } else {
                              SweetAlert.show(context,
                                  subtitle: "Canceled!",
                                  style: SweetAlertStyle.error);
                            }
                            // return false to keep dialog
                            return false;
                          });
                        },
                      ),
                      SizedBox(
                        width: screenwidth * 0.05,
                      ),

                      _homeCard(
                        context,
                        height: screenheight,
                        width: screenwidth,
                        image: 'assets/images/mcom.png',
                        onTap: () async {
                          SweetAlert.show(context,
                              subtitle:
                                  "\t\t\tFind out if you are compatible with\n\t\t\tthe person you intend to marry.\n\t\t\tBoth of you need to take the test.\n\t\t\tStart the test to find out the BEST\n\t\t\tand the BEAST before marriage",
                              style: SweetAlertStyle.confirm,
                              showCancelButton: true,
                              onPress: (bool isConfirm) {
                            if (isConfirm) {
                              myCall1();
                            } else {
                              SweetAlert.show(context,
                                  subtitle: "Canceled!",
                                  style: SweetAlertStyle.error);
                            }
                            // return false to keep dialog
                            return false;
                          });
                        },
                      ),
                      SizedBox(
                        height: screenheight * 0.2,
                      ),
                      _homeCard(
                        context,
                        height: screenheight,
                        width: screenwidth,
                        image: 'assets/images/ap.png',
                        onTap: () async {
                          SweetAlert.show(context,
                              subtitle:
                                  "\t\t\tDiscover the best academic\n\t\t\tprogram that fits your personality.\n\t\t\tClick to start.",
                              style: SweetAlertStyle.confirm,
                              showCancelButton: true,
                              onPress: (bool isConfirm) {
                            if (isConfirm) {
                              myCall2();
                            } else {
                              SweetAlert.show(context,
                                  subtitle: "Canceled!",
                                  style: SweetAlertStyle.error);
                            }
                            // return false to keep dialog
                            return false;
                          });
                        },
                      ),

                      SizedBox(
                        width: screenwidth * 0.05,
                      ),
                      _homeCard(
                        context,
                        height: screenheight,
                        width: screenwidth,
                        image: 'assets/images/pa.png',
                        onTap: () async {
                          
                          SweetAlert.show(context,
                              subtitle: "\t\t\tKnowing your personal abilities is\n\t\t\tthe way to promote mental\n\t\t\twellbeing. Take the test to explore\n\t\t\tyour abilities.",
                              style: SweetAlertStyle.confirm,
                              showCancelButton: true,
                              onPress: (bool isConfirm) {
                            if (isConfirm) {
                              myCall3();
                            } else {
                              SweetAlert.show(context,
                                  subtitle: "Canceled!",
                                  style: SweetAlertStyle.error,
                                );
                            }
                            // return false to keep dialog
                            return false;
                          });
                          // Route route =
                          //     MaterialPageRoute(builder: (c) => QuoteScreen());
                          // Navigator.push(context, route);
                        },
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
          width: width * 0.32,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
            // borderRadius: BorderRadius.all(Radius.circular(50)),
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
