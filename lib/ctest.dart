import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class Ctest extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Ctest> {
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

  var _url = 'http://www.idiscover-me.net/login';
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Future mnoti() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    String blurl = "https://icounselgh.net/presult";
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

    // Future<void> _makePhoneCall(String url) async {
    //   if (await canLaunch(url)) {
    //     await launch(url);
    //   } else {
    //     throw 'Could not launch $url';
    //   }
    // }

    return result;
  }

  Future fees() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    String blurl = "https://icounselgh.net/fes";
    var response = await http.post(Uri.parse(blurl), body: {
      "userid": userid,
    });
    var result = jsonDecode(response.body);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _makePhoneCall(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<void> _webBrowser(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Credentials ",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 20,
              ),
              child: Center(
                child: Card(
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Dear ${uname}, Use the details below to complete your personality psychometric test. Kindly call when you are done. ",
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 5),
                        // ListTile(
                        //   title: Text("Email : "),
                        //   subtitle: Text("${umail}"),
                        //   leading: Icon(Icons.email),
                        // ),
// GestureDetector(
//                                         onTap: () async {
//                                           _makePhoneCall(
//                                               "tel:+233208496496");
//                                         },
//                                         child: Container(
//                                             height: 35,
//                                             width: 85,
//                                             padding: EdgeInsets.all(4),
//                                             margin: EdgeInsets.only(
//                                                 left: 10, top: 10),
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(20)),
//                                               color:
//                                                   Theme.of(context).accentColor,
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Icon(
//                                                   Icons.call,
//                                                   size: 15,
//                                                   color: Colors.white,
//                                                 ),
//                                                 SizedBox(width: 5),
//                                                 Text("Call",
//                                                     style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 13,
//                                                         fontWeight:
//                                                             FontWeight.w600)),
//                                               ],
//                                             )),
//                                       ),

                        SizedBox(height: 10),
                        FutureBuilder(
                            future: mnoti(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                    child: Text("No result yet"),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  // ignore: missing_return
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      child: Column(children: [
                                        ListTile(
                                            title: Text("Token : "),
                                            subtitle: Text(snapshot.data[index]
                                                    ['token']
                                                .toString()),
                                            leading: Icon(Icons.password),
                                            trailing: Icon(Icons.copy),
                                            onTap: () async {
                                              Clipboard.setData(
                                                      new ClipboardData(
                                                          text: snapshot
                                                              .data[index]
                                                                  ['token']
                                                              .toString()))
                                                  .then((_) {
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Token ${snapshot.data[index]['token'].toString()} copied to clipboard")));
                                              });
                                            }),
                                        SizedBox(height: 10),
                                        ListTile(
                                            title: Text("Login at "),
                                            subtitle: Text(
                                                "http://idiscover-me.net/IHH-300486"),
                                            leading: Icon(Icons.link),
                                            trailing: Icon(Icons.copy),
                                            onTap: () async {
                                              Clipboard.setData(new ClipboardData(
                                                      text:
                                                          "http://idiscover-me.net/IHH-300486"))
                                                  .then((_) {
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "http://idiscover-me.net/IHH-300486 copied to clipboard")));
                                              });
                                            }),
                                        SizedBox(height: 4),
                                        Center(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    _webBrowser(
                                                        "http://idiscover-me.net/IHH-300486");
                                                  },
                                                  child: Container(
                                                      height: 35,
                                                      width: 130,
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      margin: EdgeInsets.only(
                                                          left: 10, top: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.call,
                                                            size: 15,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text("Click to begin",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ],
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    _makePhoneCall(
                                                        "tel:+233208496496");
                                                  },
                                                  child: Container(
                                                      height: 35,
                                                      width: 85,
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      margin: EdgeInsets.only(
                                                          left: 10, top: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        color: Colors.grey,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.call,
                                                            size: 15,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text("Call",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ],
                                                      )),
                                                ),
                                              ]),
                                        ),
                                      ]),
                                    );
                                  },
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
              ),
              child: Center(
                child: Card(
                  elevation: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          title: FutureBuilder(
                              future: fees(),
                              builder: (context, snapshot) {
                                //         return Text(
                                //         "Kindly pay an amount of Ghs10 to below number in order to recieve your psychometric report. ",style: GoogleFonts.montserrat(
                                // fontSize: 14,
                                // fontWeight: FontWeight.w600,
                                // color: Colors.black),);
                                if (snapshot.data == null) {
                                  return Container(
                                    child: Center(
                                      child: Text("No result yet"),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    // ignore: missing_return
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Text(
                                        "Kindly pay an amount of  GH₵${snapshot.data[index]['fee'].toString()}  to below number in order to recieve your psychometric report. ",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      );
                                    },
                                  );
                                }
                              }),
                        ),
                        ListTile(
                          title: Text(
                            "Dial *170#",
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Choose Transfer Money.",
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Choose MOMO user.",
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Choose MOMO user.",
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Enter MOMO Number : 0240603026.",
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Acc. Name : TUCEE institute of counseling and technology.",
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Complete the transaction and call any of below numbers",
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "0208496490 \n 0244996991",
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentExpanded extends StatelessWidget {
  final Function tapped;
  final IconData icon;
  final String current;
  final String info;

  const CurrentExpanded(
      {Key key, this.current, this.tapped, this.icon, this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      leading: Icon(this.icon, color: Colors.grey[500]),
      title: Text(
        this.current ?? "TitleKi",
        style: GoogleFonts.lato(),
      ),
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Text(
            this.info ?? "Info",
            style: GoogleFonts.lato(),
          ),
        )
      ],
    );
  }
}
