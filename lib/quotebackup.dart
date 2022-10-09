import 'dart:convert';

import 'package:flutter/material.dart';
// import './model/Slide.dart';

// import './widget/slider.dart';
import 'dart:async';
// import './slidedot.dart';

// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import './Radio.dart';
// import './more.dart';
import 'package:http/http.dart' as http;
// import './map.dart';
// import './detail.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:flutter_radio_player/flutter_radio_player.dart';
// import 'package:share/share.dart';
// import './home.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
class QuoteScreen extends StatefulWidget {
  QuoteScreen({Key key}) : super(key: key);
  // var playerState = FlutterRadioPlayer.flutter_radio_playing;
  // var volume = 0.8;

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<QuoteScreen> {
  int _currentindex = 2;
  int _currentPage = 0;

  PageController pageController;

  // int _currentPage = 0;
  // final PageController _pageController = PageController(
  //   initialPage: 0,
  // );

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _pageController.dispose();
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer.periodic(Duration(seconds: 30), (Timer timer) {
  //     if (_currentPage < 2) {
  //       _currentPage++;
  //     } else {
  //       _currentPage = 0;
  //     }
  //     _pageController.animateToPage(_currentPage,
  //         duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  //   });
  // }

  // _onPageChnaged(int index) {
  //   setState(() {
  //     _currentPage = index;
  //   });
  // }

  List<String> images = [
    // 'assets/images/1.jpg',
    // 'assets/images/2.jpg',
    // 'assets/images/3.jpg',
    // 'assets/images/4.jpg'
  ];

  // void cc()async{
  //   if(FlutterRadioPlayer.flutter_radio_paused==true){

  //     FlutterRadioPlayer.flutter_radio_playing;

  //   }

  // }

  // FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();

  // Future<void> initRadioService() async {
  //   try {
  //     await _flutterRadioPlayer.init("Favor Radio", "Live",
  //         "http://stream.zeno.fm/k5mryscq3a0uv", "false");
  //   } on PlatformException {
  //     print("Exception occurred while trying to register the services.");
  //   }
  // }

//   void autostart()async{
//   await _flutterRadioPlayer.play();
// }

  @override
  void initState() {
    super.initState();
    // initRadioService();
    // autostart();

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
    String blurl = "https://icounselgh.net/tupsu.php";
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
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("TUCEE QUOTES"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        // width: double.infinity,
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     width: double.infinity,
            //     // height: 200,
            //     child: Card(
            //       color: Colors.blue,
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Container(

            //             width: double.infinity,
            //             height: 200,
            //             child: Image.asset(
            //               'assets/images/Radio.jpg',
            //               fit: BoxFit.fill
            //             ),
            //           ),
            //           Container(
            //             width: double.infinity,
            //             height: 100,
            //             child: StreamBuilder(
            //               stream: _flutterRadioPlayer.isPlayingStream,
            //               initialData: widget.playerState,
            //               builder: (BuildContext context,
            //                   AsyncSnapshot<String> snapshot) {
            //                 String returnData = snapshot.data;
            //                 print("object data: " + returnData);
            //                 switch (returnData) {
            //                   case FlutterRadioPlayer.flutter_radio_stopped:
            //                     return RaisedButton.icon(
            //                       textColor: Colors.white,
            //                       icon: Icon(Icons.stay_current_landscape),
            //                       label: Text("Start Listening"),
            //                       color: Colors.blue,
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.all(
            //                               Radius.circular(16.0))),
            //                       onPressed: () async {
            //                         await initRadioService();
            //                       },
            //                     );
            //                     break;
            //                   case FlutterRadioPlayer.flutter_radio_loading:
            //                     return Text("Loading stream...");
            //                   case FlutterRadioPlayer.flutter_radio_error:
            //                     return RaisedButton.icon(
            //                       textColor: Colors.white,
            //                       icon: Icon(Icons.refresh),
            //                       label: Text("Retry Listening"),
            //                       color: Colors.blue,
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.all(
            //                               Radius.circular(16.0))),
            //                       onPressed: () async {
            //                         await initRadioService();
            //                       },
            //                     );
            //                     break;

            //                     break;
            //                   default:
            //                     return Row(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.center,
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceEvenly,
            //                         children: <Widget>[
            //                           RaisedButton.icon(
            //                             textColor: Colors.black,
            //                             icon: snapshot.data ==
            //                                     FlutterRadioPlayer
            //                                         .flutter_radio_playing
            //                                 ? Icon(Icons.pause)
            //                                 : Icon(Icons.play_arrow),
            //                             label: snapshot.data ==
            //                                     FlutterRadioPlayer
            //                                         .flutter_radio_playing
            //                                 ? Text("Pause")
            //                                 : Text("Play"),
            //                             color: Colors.white,
            //                             shape: RoundedRectangleBorder(
            //                                 borderRadius: BorderRadius.all(
            //                                     Radius.circular(16.0))),
            //                             onPressed: () async {
            //                               print("button press data: " +
            //                                   snapshot.data.toString());
            //                               await _flutterRadioPlayer
            //                                   .playOrPause();
            //                             },
            //                           ),
            //                           RaisedButton.icon(

            //                             textColor: Colors.black,
            //                             icon: Icon(Icons.stop),
            //                             label: Text("Stop"),
            //                             color: Colors.white,
            //                             shape: RoundedRectangleBorder(

            //                                 borderRadius: BorderRadius.all(
            //                                     Radius.circular(16.0))),
            //                             onPressed: () async {
            //                               print("button press data: " +
            //                                   snapshot.data.toString());
            //                               await _flutterRadioPlayer.stop();
            //                             },
            //                           ),
            //                         ]);
            //                     break;
            //                 }
            //               },
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     width: double.infinity,
            //     height: 20,
            //     child: Image.asset("assets/images/2.jpg", fit: BoxFit.cover),
            //   ),
            // ),
            // Expanded(flex: 1,child: Container()),
            Expanded(
              // flex: 10,
              child: Container(
                  // decoration: imageD,
                  padding: EdgeInsets.only(top: 20),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text(
                          //   "TUPSU",
                          //   style: TextStyle(
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),

                          // SizedBox(
                          //   height: 1,
                          // ),
                         Container(
            margin: EdgeInsets.only(
                left: screenwidth * 0.05, right: screenwidth * 0.05),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xfffaab3b),
            ),
            child: Text(
              "TUCEE quotes provide you with thought-provoking statements that are transformational, inspirational, revealing and entertaining.  Read and share to help others.'",
              style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),

          SizedBox(
            height: 10,
          ),

                          Container(
                            // flex: 1,
                            height: screenheight * 0.5,
                            child: FutureBuilder(
                                future: ptest(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                    return Text("LOADING");

                                  if (snapshot.connectionState ==
                                      ConnectionState
                                          .done) if (snapshot.hasData) {
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
                          SizedBox(
                            height: 10,
                          ),
                          //           Text(
                          //             "Verse of The Day",
                          //             style: TextStyle(
                          //               fontSize: 18,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //           Container(
                          //             // flex: 1,

                          //             child: Center(
                          //               child:FutureBuilder(
                          //                 future: verseCall(),
                          //                 builder: (context, snapshot) {
                          //                   if(snapshot.connectionState == ConnectionState.waiting)
                          //                     return Text("lOADING");

                          //                   if(snapshot.connectionState == ConnectionState.done)
                          //                     if(snapshot.hasData) {
                          //                       List images = snapshot.data;

                          //                       return   SizedBox(
                          //                 height: Curves.easeInOut.transform(1) * 400,
                          //                 width: Curves.easeInOut.transform(1) *
                          //                     double.infinity,
                          //                 child: Container(
                          //                   margin: EdgeInsets.all(5),
                          //                   child: Card(
                          //                     elevation: 15,
                          //                     child: Column(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.spaceBetween,
                          //                       children: [
                          //                         Image.network("http://radio.favorchapel.com/upload/"+ snapshot.data[0]['vpic'],
                          //                             fit: BoxFit.cover,
                          //                             errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                          // loadingBuilder: (context, child, loadingProgress) => loadingProgress != null ? Center(child: CircularProgressIndicator()) : child,
                          //                             ),
                          //                         // SizedBox(height: 5,),

                          //                         Text(
                          //                           snapshot.data[0]['dateadded'],
                          //                           style: TextStyle(
                          //                             fontSize: 10,
                          //                             color: Colors.red,
                          //                           ),
                          //                           textAlign: TextAlign.left,
                          //                         ),

                          //                         Text(
                          //                           snapshot.data[0]['vtitle'],
                          //                           style: TextStyle(
                          //                             fontWeight: FontWeight.bold,
                          //                           ),
                          //                         ),

                          //                         Container(
                          //                           padding: EdgeInsets.only(left: 10,right: 10),
                          //                           child: Text(
                          //                               snapshot.data[0]['vdetail']),
                          //                         ),

                          //                         // RaisedButton(
                          //                         //   onPressed: () {},
                          //                         //   shape: RoundedRectangleBorder(
                          //                         //       borderRadius: BorderRadius.circular(80.0)),
                          //                         //   padding: const EdgeInsets.all(0.0),
                          //                         //   child: Ink(
                          //                         //     decoration: const BoxDecoration(
                          //                         //       gradient: LinearGradient(
                          //                         //         colors: <Color>[
                          //                         //           Color(0xFF0D47A1),
                          //                         //           Color(0xFF1976D2),
                          //                         //           Color(0xFF42A5F5),
                          //                         //         ],
                          //                         //       ),
                          //                         //       borderRadius: BorderRadius.all(Radius.circular(80.0)),
                          //                         //     ),
                          //                         //     child: Container(
                          //                         //       constraints: const BoxConstraints(
                          //                         //           minWidth: 80.0,
                          //                         //           minHeight: 36.0), // min sizes for Material buttons
                          //                         //       alignment: Alignment.center,
                          //                         //       child: const Text(
                          //                         //         'Read Now',
                          //                         //         textAlign: TextAlign.center,
                          //                         //         style: TextStyle(color: Colors.white),
                          //                         //       ),
                          //                         //     ),
                          //                         //   ),
                          //                         // )

                          //                         Container(
                          //                           child: Row(
                          //                             children: [
                          //                               RaisedButton.icon(
                          //                                 onPressed: () {
                          //                                   Share.share(snapshot.data[0]['vdetail'],
                          //                                   subject: snapshot.data[0]['vtitle']);
                          //                                 },
                          //                                 color: Colors.transparent,
                          //                                 disabledColor:
                          //                                     Colors.transparent,
                          //                                 icon: Icon(
                          //                                   Icons.share,
                          //                                   color: Colors.blue,
                          //                                 ),
                          //                                 label: Text(
                          //                                   "Share",
                          //                                   style: TextStyle(
                          //                                     color: Colors.blue,
                          //                                   ),
                          //                                 ),
                          //                               )
                          //                             ],
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),
                          //               );
                          //                     }
                          //                   return Text("eRROR");

                          //                 },
                          //               )
                          //             ),
                          //           )
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  imageSlider(int index, Map details) {
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
            width: Curves.easeInOut.transform(value) * 210,
            child: widget,
          ),
        );
      },
      child: Container(

        margin: EdgeInsets.all(5),
        child: Card(
          elevation: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: [
              Container(
                height: 270,
                width: double.infinity,
                child: Image.network(
                  "https://icounselgh.net/default/upload/${details['pic']}",
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
                      final imageurl = 'https://icounselgh.net/default/upload/${details['pic']}';
                      final uri = Uri.parse(imageurl);
                      final response = await http.get(uri);
                      final bytes = response.bodyBytes;
                      final temp = await getTemporaryDirectory();
                      final path = '${temp.path}/image.jpg';
                      File(path).writeAsBytesSync(bytes);
                      await Share.shareFiles([path],text: "${details['title']}");
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
}
