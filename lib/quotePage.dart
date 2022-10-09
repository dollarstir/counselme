import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icounselgh/feedback.dart';
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
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:icounselgh/models/channel_info.dart';
import 'package:icounselgh/models/viideos_list.dart';
import 'package:icounselgh/screens/video_player_screen.dart';
import 'package:icounselgh/utils/services.dart';
import 'package:share_plus/share_plus.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  int _currentindex = 2;
  int _currentPage = 0;

  PageController pageController;

  List<String> images = [
    // 'assets/images/1.jpg',
    // 'assets/images/2.jpg',
    // 'assets/images/3.jpg',
    // 'assets/images/4.jpg'
  ];

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.6,
    );

    Timer.periodic(Duration(seconds: 15), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  _onPageChnaged(int index) {
    // setState(() {
    _currentPage = index;
    // });
  }

  Future ptest() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    String blurl = "https://icounselgh.net/tupsu";
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

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenheight * 0.05),
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
                'TUCEE',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                ' QUOTES',
                style: GoogleFonts.montserrat(
                    fontSize: 21,
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                    height: screenheight * 0.354,
                    child: Container(
                      // color: Colors.blue,
                      padding: EdgeInsets.only(top: 0, right: 20, left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(child:Image(image:  AssetImage('assets/images/tq.png'),width: screenwidth * 0.3,)),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20,bottom: 5),
                            child: Text(
                              'TUCEE quotes provide you with \nthought-provoking statements that are transformational, inspirational, revealing and entertaining.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Read and share to help others.',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xfffaab3b)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: screenheight * 0.50,
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
              bottom: screenheight * (-0.030),
              left: screenwidth * -0.057,
              child: GestureDetector(
                onTap: ()async{
              Route route = MaterialPageRoute(builder: (c) => fdb());
              Navigator.push(context, route);

            },
                child: Image.asset(
                  "assets/images/motto.png",
                  height: 130,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

            Positioned(
              bottom: screenheight * .10,
              left: screenwidth * 0.05,
              right: screenwidth * 0.05,
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        // flex: 1,
                        height: screenheight * 0.44,
                        // width : screenwidth * 1.2,
                        child: FutureBuilder(
                            future: ptest(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return Text("LOADING");

                              if (snapshot.connectionState ==
                                  ConnectionState.done) if (snapshot.hasData) {
                                List images = snapshot.data;

                                return PageView.builder(
                                  controller: pageController,
                                  onPageChanged: _onPageChnaged,
                                  itemCount: images.length,
                                  itemBuilder: (context, position) {
                                    return imageSlider(
                                        position, images[position]);
                                  },
                                );
                              }
                              return Text("No TUPSU available");
                            }),
                      ),
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

  imageSlider(int index, Map details) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.1, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 450,
            width: Curves.easeInOut.transform(value) * 230,
            child: widget,
          ),
        );
      },
      child: Container(
        width: screenwidth * 0.7,
        margin: EdgeInsets.all(5),
        child: Card(
          elevation: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 230,
                width: double.infinity,
                // padding: EdgeInsets.all(2),
                child: Image.network(
                  "https://icounselgh.net/main/default/upload/${details['pic']}",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error),
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress != null
                          ? Center(child: CircularProgressIndicator())
                          : child,
                ),
              ),
              // SizedBox(height: 5,),

              // Text("${details['title']}"),
              Container(
                  width: 150,
                  child: RaisedButton(
                    onPressed: () async {
                      final imageurl =
                          'https://icounselgh.net/main/default/upload/${details['pic']}';
                      final uri = Uri.parse(imageurl);
                      final response = await http.get(uri);
                      final bytes = response.bodyBytes;
                      final temp = await getTemporaryDirectory();
                      final path = '${temp.path}/image.jpg';
                      File(path).writeAsBytesSync(bytes);
                      await Share.shareFiles([path],
                          text: "${details['title']}");
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFFFF7d33),
                            Color(0xFFFFbb33),
                            Color(0xFFFFe033),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 80.0,
                            minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: const Text(
                          'Share',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
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
      String blurl = "https://icounselgh.net/mnotify.php";
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
