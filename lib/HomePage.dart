// import 'dart:convert';
// import 'dart:ffi';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:icounselgh/BookSection.dart';
import 'package:icounselgh/ReviewPage.dart';
import 'package:icounselgh/activity.dart';
import 'package:icounselgh/cconnect.dart';
import 'package:icounselgh/cform.dart';
import 'package:icounselgh/choose.dart';
import 'package:icounselgh/counsellorProfilePage.dart';
import 'package:icounselgh/creg.dart';
import 'package:icounselgh/ctest.dart';
import 'package:icounselgh/discover.dart';
import 'package:icounselgh/feedback.dart';
import 'package:icounselgh/instantSession.dart';
import 'package:icounselgh/loginPage.dart';
import 'package:icounselgh/mnotify.dart';
import 'package:icounselgh/profilepage.dart';
import 'package:icounselgh/quotePage.dart';
import 'package:icounselgh/searchPage.dart';
import 'package:icounselgh/settings.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icounselgh/tuceetalk.dart';
// import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'notifications.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> screens = [
    Home(),
    Review(),
    Activity(),
    Settings(),
    Myprofile(),
  ];
  int selectedIndex = 0;
  Box hiveBox = Hive.box("icousel");

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  String country = "Counsellors location";
  String category = "Counselling Need";
  bool selected = false;
  bool selectedloc = false;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    // _initPackageInfo();
    checkVersion().listen((event) {
      print('Current version : ' + event);

      if(event == 'update available'){
        creatNotificationupdate();
      }
      
    });


    hiveBox.put("counsellor_category", "");
    hiveBox.put("counsellor_location", "");
    hiveBox.put("counsellor_name", "");
    hiveBox.put("counsellor_group", "");
  }

  Future _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    return  info.version;
  }

  Future ads() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    String blurl = "https://icounselgh.net/ads";
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
  var applink = 'https://play.google.com/store/apps/details?id=com.tuceehub.icounselgh';

  Future version() async {
    String blurl = "https://icounselgh.net/version";
    var response = await http.post(Uri.parse(blurl), body: {
      "userid": '1',
    });
    var result = jsonDecode(response.body);

    return result;
  }

  Stream checkVersion() async*{
    var  myv= await _initPackageInfo(); 
    myv = myv.replaceAll('.','');
    myv = int.parse(myv);
    var cver = await version();
    var currentversion  = cver[0]['version'];
    currentversion = currentversion.replaceAll('.','');
    currentversion = int.parse(currentversion);
    var ss = '';
    if(currentversion > myv){
      ss = 'update available';

    }
    else{
      ss ='uptodate';
    }
    yield ss;

  }

  static Stream<int> getcount() =>
      Stream.periodic(Duration(seconds: 5)).asyncMap((_) => ncount());

  static Future<int> ncount() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    var userlink = "https://icounselgh.net/ncount";
    try {
      var response = await http.post(
        Uri.parse(userlink),
        body: {'uid': userid},
      );
      print(response.body);
      var result = jsonDecode(response.body);
      result = int.parse(result.toString());
      return result;
    } catch (e) {
      print(e);
    }

    return 0;
  }

  final int cipro = 0;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: ConvexAppBar(
          // selectedItemColor: Colors.black,
          // unselectedItemColor: Colors.green,
          backgroundColor: Theme.of(context).accentColor, //Color(0xFF0731aa),
          style: TabStyle.react,
          items: [
            TabItem(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: "Home",
            ),
            TabItem(
              icon: const Icon(
                Icons.star,
                color: Colors.white,
              ),
              title: "Reviews",
            ),
            // TabItem(
            //   icon: const Icon(
            //     Icons.search,
            //     color: Colors.white,
            //   ),
            //   title: "Counsellors",
            // ),
            TabItem(
              icon: const Icon(
                Icons.local_activity,
                color: Colors.white,
              ),
              title: "Bookings",
            ),

            TabItem(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: "Settings",
            ),
            TabItem(
              icon: const Icon(
                Icons.verified_user,
                color: Colors.white,
              ),
              title: "Profile",
            ),
          ],
          initialActiveIndex: selectedIndex,
          onTap: onTabTapped,
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //0xfffaab3),
          backgroundColor: Color(0xfffaab3b),
          title: Container(
            margin: EdgeInsets.only(
                top: screenheight * 0.13, left: screenwidth * 0),
            child: Container(
              child: Image(
                image: AssetImage(
                  'assets/images/logo1.png',
                ),
                width: screenwidth * 0.6,
                // height: screenheight * 0.3,
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Text(
          //   "Counsel-Me",
          //   style: TextStyle(
          //       color: Theme.of(context).accentColor,
          //       fontWeight: FontWeight.bold),
          // ),
          elevation: selectedIndex == 5 ? 8.0 : 0,
          //flexibleSpace: Container(height: 10, color: Colors.blue,),
          bottom: (selectedIndex == 5
              ? PreferredSize(
                  child: Container(
                    child: Column(
                      children: [
                        CustomSearchTextField(
                          onChanged: (String value) {
                            //selected = true;
                            String name = value.toLowerCase();
                            // print(category);
                            hiveBox.put("counsellor_name", name);
                          },
                          data: Icons.search,
                          isObsecure: false,
                          hintText: "Search by  counsellor's name...",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ChooseCategory(
                                categories: [
                                  'Counselling Need',
                                  'All Categories',
                                  'Academic and Career',
                                  'Relationship and Marriage',
                                  'Regenerative Health',
                                  'Behaviour Modifications',
                                  'Crisis and Bereavement',
                                  'Addiction',
                                  'Financial',
                                  'Reproductive Health',
                                  'Sexuality Crisis'
                                ],
                                category: category,
                                selected: selected,
                                onChanged: (val) {
                                  setState(() {
                                    //selected = true;
                                    category = val;
                                    // print(category);
                                    if (category == 'Counselling Need') {
                                      hiveBox.put("counsellor_category", "");
                                      selected = false;
                                      // print(selected);
                                    } else {
                                      hiveBox.put("counsellor_category", val);
                                      selected = true;
                                      // print(selected);
                                    }
                                  });
                                }),
                            ChooseLocation(
                                countries: [
                                  'Counsellors location',
                                  'Ahafo',
                                  'Ashanti',
                                  'Bono',
                                  'Bono East',
                                  'Central',
                                  'Eastern',
                                  'Greater Accra',
                                  'North East',
                                  'Northern',
                                  'Oti',
                                  'Savannah',
                                  'Upper East',
                                  'Upper West',
                                  'Volta',
                                  'Western',
                                  'Western North'
                                ],
                                country: country,
                                selectedloc: selectedloc,
                                onChanged: (val) {
                                  setState(() {
                                    country = val;

                                    // print(country);
                                    if (country == 'Counsellors location') {
                                      hiveBox.put("counsellor_location", "");
                                      selectedloc = false;
                                      // print(selectedloc);
                                    } else {
                                      hiveBox.put("counsellor_location", val);
                                      selectedloc = true;
                                      // print(selectedloc);
                                    }
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                    //color: Colors.blue,
                  ),
                  preferredSize: Size.fromHeight(95),
                )
              : PreferredSize(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // ChooseCategory(
                        //     categories: [
                        //       'Counselling Need',
                        //       'All Categories',
                        //       'Academic and Career',
                        //       'Relationship and Marriage',
                        //       'Regenerative Health',
                        //       'Behaviour Modifications',
                        //       'Crisis and Bereavement',
                        //       'Addiction',
                        //       'Financial',
                        //       'Reproductive Health',
                        //       'Sexuality Crisis'
                        //     ],
                        //     category: category,
                        //     selected: selected,
                        //     onChanged: (val) {
                        //       setState(() {
                        //         category = val;
                        //         // print(category);
                        //         if (category == 'Counselling Need') {
                        //           hiveBox.put("counsellor_category", "");

                        //           selected = false;
                        //           // print(selected);
                        //         } else {
                        //           hiveBox.put("counsellor_category", val);

                        //           selected = true;
                        //           // print(selected);
                        //         }
                        //       });
                        //     }),
                        // ChooseLocation(
                        //     countries: [
                        //       'Counsellors location',
                        //       'Ahafo',
                        //       'Ashanti',
                        //       'Bono',
                        //       'Bono East',
                        //       'Central',
                        //       'Eastern',
                        //       'Greater Accra',
                        //       'North East',
                        //       'Northern',
                        //       'Oti',
                        //       'Savannah',
                        //       'Upper East',
                        //       'Upper West',
                        //       'Volta',
                        //       'Western',
                        //       'Western North'
                        //     ],
                        //     country: country,
                        //     selectedloc: selectedloc,
                        //     onChanged: (val) {
                        //       setState(() {
                        //         country = val;
                        //         // print(country);
                        //         if (country == 'Counsellors location') {
                        //           hiveBox.put("counsellor_location", "");

                        //           selectedloc = false;
                        //           // print(selectedloc);
                        //         } else {
                        //           hiveBox.put("counsellor_location", val);

                        //           selectedloc = true;
                        //           // print(selectedloc);
                        //         }
                        //       });
                        //     }),
                      ],
                    ),
                    //color: Colors.blue,
                  ),
                  preferredSize: Size.fromHeight(-10),
                )),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications, color: Color(0xffcec7c2)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Mnotify()));
                  },
                ),
                Positioned(
                  child: Stack(children: [
                    Positioned(
                      child: Icon(
                        Icons.brightness_1,
                        size: 21.0,
                        color: Color(0xffff7401),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      right: 4,
                      bottom: 4,
                      child: StreamBuilder<int>(
                          initialData: cipro,
                          stream: getcount(),
                          builder: (context, snapshot) {
                            final int cipro = snapshot.data;
                            return Text(
                              cipro.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            );
                          }),
                    )
                  ]),
                )
              ],
            ),
          ],
        ),
        body: screens[selectedIndex]);
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Future Getcounsellor() async {
  //   var resp = await http.get("https://icounselgh.net/cc.php");
  //   var decoded = jsonDecode(resp.body);
  //   //  return decoded;
  //   // print(decoded);
  //   List<Counsellor> couns = [];
  //   for (var c in decoded) {
  //     Counsellor cc = Counsellor(c['id'], c['name'], c['email'], c['contact'],
  //         c['region'], c['type'], c['status'],c['pic']);
  //     couns.add(cc);
  //     // print(couns);
  //   }
  //   return couns;
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

  Future<void> _webBrowser(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

  Future ads() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    String blurl = "https://icounselgh.net/ads";
    var response = await http.post(Uri.parse(blurl), body: {
      "userid": userid,
    });
    var result = jsonDecode(response.body);
    print(result);
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

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    double _addedMargin = 200;

    return Stack(
      children: [
        SizedBox(width: screenwidth, height: screenheight),
        // ClipPath(
        // clipper: SemiCircleClipper(),
        // child:
        Positioned(
          top: -(_addedMargin * .23),
          bottom: 0,
          left: -(_addedMargin * .5),
          right: -(_addedMargin * .5),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: (screenwidth + _addedMargin) * .5,
              width: screenwidth + _addedMargin,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/circles.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(screenwidth + _addedMargin),
                ),
                color: Color(0xfffaab3b),
              ),

              // child :Container(
              // width: 50,
              // height: 50,
              // color: Colors.amberAccent,
              //   child: Positioned(
              //     child: Text("kofi"),
              //   ),
              // ),
            ),
          ),
        ),

        Positioned(
          // bottom: 440,top
          top: screenheight * .02,
          left: screenwidth * 0.16,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FutureBuilder(
              future: ads(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // print("Width: ${(screenwidth * 0.68)}");
                  // print("Height: ${(screenheight * 0.18)}");

                  return SizedBox(
                    width: screenwidth * 0.68,
                    height: screenheight * 0.18,
                    child: Image.asset(
                      'assets/images/t3.jpg',
                      fit: BoxFit.fill,
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List images = snapshot.data;

                    return ImageSlideshow(
                      width: screenwidth * 0.68,
                      height: screenheight * 0.18,
                      initialPage: 0,
                      indicatorColor: Colors.blue,
                      indicatorBackgroundColor: Colors.grey,
                      onPageChanged: (value) {
                        // debugPrint('Page changed: $value');
                      },
                      autoPlayInterval: 3000,
                      isLoop: true,
                      children: images.map(
                        (_image) {
                          return GestureDetector(
                            onTap: () async {
                                                    _webBrowser(_image['title']);
                                                  },
                            child: Image.network(
                              "https://icounselgh.net/main/default/upload/${_image["pic"]}",
                              width: double.infinity,
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          );
                        },
                      ).toList(),
                    );
                  }
                }
                return SizedBox(
                  width: screenwidth * 0.68,
                  height: screenheight * 0.18,
                  child: Image.asset(
                    'assets/images/t2.jpg',
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),

            // Image.asset(
            //       'assets/images/t1.jpg',
            //       fit: BoxFit.cover,
            // ),
            // Image.asset(
            //       'assets/images/t2.jpg',
            //       fit: BoxFit.cover,
            // ),
            // Image.asset(
            //       'assets/images/t3.jpg',
            //       fit: BoxFit.cover,
            // ),
          ),
        ),

        Positioned(
          bottom: screenheight * (-0.016),
          left: screenwidth * 0.12,
          child: GestureDetector(
            onTap: () async {
              Route route = MaterialPageRoute(builder: (c) => fdb());
              Navigator.push(context, route);
            },
            child: Image.asset(
              "assets/images/motto.png",
              height: 100,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),

        // ),
        Positioned(
          top: screenheight * .245,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  _homeCard(
                    context,
                    height: screenheight,
                    width: screenwidth,
                    image: 'assets/images/cs.png',
                    onTap: () {
                      Route route = MaterialPageRoute(
                        builder: (c) => InstantSessionPage(),
                      );
                      Navigator.push(context, route);
                    },
                  ),
                  SizedBox(
                    width: screenwidth * 0.05,
                  ),
                  _homeCard(
                    context,
                    height: screenheight,
                    width: screenwidth,
                    image: 'assets/images/idis.png',
                    onTap: () {
                      Route route = MaterialPageRoute(
                        builder: (c) => Discover(),
                      );
                      Navigator.push(context, route);
                      //   SweetAlert.show(
                      //     context,
                      //     title: "Loading ..",
                      //     subtitle: "Please wait...",
                      //     style: SweetAlertStyle.loading,
                      //   );

                      //   var repo = await ptest();

                      //   print(repo);

                      //   if (repo == "pending") {
                      //     SweetAlert.show(
                      //       context,
                      //       title: "Welcome!",
                      //       subtitle: "Your request is under review",
                      //       style: SweetAlertStyle.error,
                      //     );
                      //   } else if (repo == "approved") {
                      //     Navigator.of(context).pop();
                      //     Route route =
                      //         MaterialPageRoute(builder: (c) => Ctest());
                      //     Navigator.push(context, route);
                      //   } else if (repo == "sent") {
                      //     SweetAlert.show(
                      //       context,
                      //       title: "Congrats!!",
                      //       subtitle: 'Your request is being proccessed',
                      //       style: SweetAlertStyle.success,
                      //     );
                      //   } else if (repo == "failed") {}
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.18,
                  ),
                  _homeCard(
                    context,
                    height: screenheight,
                    width: screenwidth,
                    image: 'assets/images/creg.png',
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (c) => Cregister());
                      Navigator.push(context, route);
                    },
                  ),
                  SizedBox(
                    width: screenwidth * 0.05,
                  ),
                  _homeCard(
                    context,
                    height: screenheight,
                    width: screenwidth,
                    image: 'assets/images/tq.png',
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (c) => QuoteScreen());
                      Navigator.push(context, route);
                    },
                  ),
                  SizedBox(
                    height: screenheight * 0.18,
                  ),
                  _homeCard(
                    context,
                    height: screenheight,
                    width: screenwidth,
                    image: 'assets/images/ccon.png',
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (c) => Cconnect());
                      Navigator.push(context, route);
                    },
                  ),
                  SizedBox(
                    width: screenwidth * 0.05,
                  ),
                  _homeCard(
                    context,
                    height: screenheight,
                    width: screenwidth,
                    image: 'assets/images/ttalk.png',
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) => Ttalk());
                      Navigator.push(context, route);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SingleChildScrollView(

        //   child:
        //       // CounsellorTile(),
        //       // CounsellorTile(),
        //       Expanded(child: CounsellorTile()),

        // ),

        SizedBox(height: screenheight * 0.01),
        // Text("    Our Services"),
        // SizedBox(width: 20),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Wrap(
              children: [
                // GestureDetector(
                //   onTap: () {
                //     Route route =
                //         MaterialPageRoute(builder: (c) => BookSession());
                //     Navigator.push(context, route);
                //   },
                //   child: Container(
                //     height: 80,
                //     margin: EdgeInsets.only(left: 10, top: 10),
                //     width: 150,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //       color: Colors.red,
                //     ),
                //     child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Icon(
                //                 Icons.person,
                //                 color: Colors.white,
                //               ),
                //               Icon(
                //                 Icons.arrow_forward,
                //                 color: Colors.white,
                //               ),
                //               Icon(
                //                 Icons.date_range,
                //                 color: Colors.white,
                //               ),
                //             ],
                //           ),
                //           SizedBox(height: 10),
                //           Text("Book a session",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w500))
                //         ]),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Route route =
                //         MaterialPageRoute(builder: (c) => InstantSessionPage());
                //     Navigator.push(context, route);
                //   },
                //   child: Container(
                //     height: 80,
                //     margin: EdgeInsets.only(left: 10, top: 10),
                //     width: 150,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //       color: Colors.cyan,
                //     ),
                //     child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Icon(
                //                 Icons.person,
                //                 color: Colors.white,
                //               ),
                //               Icon(
                //                 Icons.data_usage,
                //                 color: Colors.white,
                //               ),
                //               Icon(
                //                 Icons.person,
                //                 color: Colors.white,
                //               ),
                //             ],
                //           ),
                //           SizedBox(height: 10),
                //           Text("Start an instant\n session",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w500))
                //         ]),
                //   ),
                // ),

                SizedBox(height: 20),
                // GestureDetector(
                //   onTap: () {
                //     Route route =
                //         MaterialPageRoute(builder: (c) => InstantSessionPage());
                //     Navigator.push(context, route);
                //   },
                //   child: Container(
                //     height: 80,
                //     margin: EdgeInsets.only(left: 10, top: 10),
                //     width: 150,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //       color: Colors.red,
                //     ),
                //     child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Icon(
                //                 Icons.person,
                //                 color: Colors.white,
                //               ),
                //               Icon(
                //                 Icons.arrow_forward,
                //                 color: Colors.white,
                //               ),
                //               Icon(
                //                 Icons.date_range,
                //                 color: Colors.white,
                //               ),
                //             ],
                //           ),
                //           SizedBox(height: 10),
                //           Text("Start instant session",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w500))
                //         ]),
                //   ),
                // ),

                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => InstantSessionPage());
                    Navigator.push(context, route);
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: screenheight * 0.13,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      width: screenwidth * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/cs.png'),
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
                ),

                GestureDetector(
                  onTap: () async {
                    SweetAlert.show(
                      context,
                      title: "Loading ..",
                      subtitle: "Please wait...",
                      style: SweetAlertStyle.loading,
                    );

                    var repo = await ptest();

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
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: screenheight * 0.13,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      width: screenwidth * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/idis.png'),
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
                ),
                // GestureDetector(
                //   onTap: () {
                //     Route route =
                //         MaterialPageRoute(builder: (c) => InstantSessionPage());
                //     Navigator.push(context, route);
                //   },
                //   child: Container(
                //     height: 80,
                //     margin: EdgeInsets.only(left: 10, top: 10),
                //     width: 150,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //       color: Colors.cyan,
                //     ),
                //     child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Icon(
                //                 Icons.person,
                //                 color: Colors.white,
                //               ),
                //               Icon(
                //                 Icons.data_usage,
                //                 color: Colors.white,
                //               ),
                //               Icon(
                //                 Icons.person,
                //                 color: Colors.white,
                //               ),
                //             ],
                //           ),
                //           SizedBox(height: 10),
                //           Text("Search for counsellor",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w500))
                //         ]),
                //   ),
                // ),

                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => InstantSessionPage());
                    Navigator.push(context, route);
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: screenheight * 0.13,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      width: screenwidth * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/creg.png'),
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
                ),
                // GestureDetector(
                //   onTap: () {
                //     Route route =
                //         MaterialPageRoute(builder: (c) => BookSession());
                //     Navigator.push(context, route);
                //   },
                //   child: Container(
                //     height: 80,
                //     margin: EdgeInsets.only(left: 10, top: 10),
                //     width: 150,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //       color: Colors.red,
                //     ),
                //     child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Icon(
                //                 Icons.person,
                //                 color: Colors.white,
                //               ),
                //               Icon(
                //                 Icons.arrow_forward,
                //                 color: Colors.white,
                //               ),
                //               Icon(
                //                 Icons.date_range,
                //                 color: Colors.white,
                //               ),
                //             ],
                //           ),
                //           SizedBox(height: 10),
                //           Text("Register as a Counsellor",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w500))
                //         ]),
                //   ),
                // ),

                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => QuoteScreen());
                    Navigator.push(context, route);
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: screenheight * 0.13,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      width: screenwidth * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/tq.png'),
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
                ),
                //  GestureDetector(
                //     onTap: () {
                //       Route route =
                //           MaterialPageRoute(builder: (c) => QuoteScreen());
                //       Navigator.push(context, route);
                //     },
                //     child: Container(
                //       height: 80,
                //       margin: EdgeInsets.only(left: 10, top: 10),
                //       width: 150,
                //       decoration: BoxDecoration(
                //         image: DecorationImage(
                //           image: AssetImage('assets/images/ttk.jpg'),
                //           fit: BoxFit.cover,
                //         ),
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //         color: Colors.purple,
                //       ),
                //       // child: Image(
                //       //   image: AssetImage(
                //       //       "assets/images/gt.png"),
                //       //   // fit: BoxFit.cover,
                //       //   alignment: Alignment.topCenter,
                //       // ),
                //     ),
                //   ),

                SizedBox(height: 10),

                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => QuoteScreen());
                    Navigator.push(context, route);
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: screenheight * 0.13,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      width: screenwidth * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ccon.png'),
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
                ),
                // GestureDetector(
                //   onTap: () {
                //     Route route =
                //         MaterialPageRoute(builder: (c) => QuoteScreen());
                //     Navigator.push(context, route);
                //   },
                //   child: Container(
                //     height: 80,
                //     margin: EdgeInsets.only(left: 10, top: 10),
                //     width: 150,
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage('assets/images/gt.png'),
                //         fit: BoxFit.cover,
                //       ),
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //       color: Colors.purple,
                //     ),
                //     // child: Image(
                //     //   image: AssetImage(
                //     //       "assets/images/gt.png"),
                //     //   // fit: BoxFit.cover,
                //     //   alignment: Alignment.topCenter,
                //     // ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () async {
                //     SweetAlert.show(
                //       context,
                //       title: "Loading ..",
                //       subtitle: "Please wait...",
                //       style: SweetAlertStyle.loading,
                //     );

                //     var repo = await ptest();

                //     print(repo);

                //     if (repo == "pending") {
                //       SweetAlert.show(
                //         context,
                //         title: "Welcome!",
                //         subtitle: "Your request is under review",
                //         style: SweetAlertStyle.error,
                //       );
                //     } else if (repo == "approved") {
                //       Navigator.of(context).pop();
                //       Route route = MaterialPageRoute(builder: (c) => Ctest());
                //       Navigator.push(context, route);
                //     } else if (repo == "sent") {
                //       SweetAlert.show(
                //         context,
                //         title: "Congrats!!",
                //         subtitle: 'Your request is being proccessed',
                //         style: SweetAlertStyle.success,
                //       );
                //     } else if (repo == "failed") {}
                //   },
                //   child: Container(
                //     height: 80,
                //     margin: EdgeInsets.only(left: 10, top: 10),
                //     width: 150,
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage('assets/images/gp.png'),
                //         fit: BoxFit.cover,
                //       ),
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //       color: Colors.black,
                //     ),
                //     // child:  Image(
                //     //   image: AssetImage(
                //     //       "assets/images/gp.png"),
                //     //   // fit: BoxFit.contain,
                //     //   alignment: Alignment.topCenter,
                //     // ),
                //   ),
                // ),

                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => QuoteScreen());
                    Navigator.push(context, route);
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: screenheight * 0.13,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      width: screenwidth * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ttalk.png'),
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
                ),
              ],
            ),
          ),
        ),
        // SizedBox(height: 10),
        // Text("    Our Counsellors"),
        // // CounsellorTile(),
        // // CounsellorTile(),
        // Expanded(child: CounsellorTile()),
      ],
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
        elevation: 10,
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

class SemiCircleClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double _radius = 50;
    double _width = size.width;
    double _height = size.height;

    Path path = Path()
      ..moveTo(0, _height * .2)
      ..arcToPoint(
        Offset(_width, _height * .2),
        radius: Radius.circular(_radius),
      )
      ..moveTo(_width, 0)
      ..moveTo(0, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

class CounsellorTile extends StatelessWidget {
  var cid;
  String name;
  String type;
  String location;
  String image;

  CounsellorTile({this.cid, this.name, this.type, this.location, this.image});
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    Future Getcounsellor() async {
      var rl = "https://icounselgh.net/cc";
      var resp = await http.get(
        Uri.parse(rl),
        headers: {"Accept": "application/json"},
      );
      var decoded = jsonDecode(resp.body);
      //  return decoded;
      //  print(decoded);
      List<Counsellor> couns = [];
      for (var c in decoded) {
        Counsellor cc = Counsellor(
            c['id'],
            c['name'],
            c['email'],
            c['contact'],
            c['region'],
            c['type'],
            c['cgroup'],
            c['gpcpin'],
            c['status'],
            c['pic'],
            c['bio']);
        couns.add(cc);
      }
      // print(couns.length);
      return couns;
    }

    Future cftest() async {
      var box = Hive.box("icousel");
      var userid = box.get("userid");
      var userlink = "https://icounselgh.net/cftest.php";
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
            future: Getcounsellor(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("No result found"),
                  ),
                );
              } else {
                List<Counsellor> counsellors = snapshot.data;

                counsellors = counsellors.where((element) {
                  String loc = Hive.box("icousel").get("counsellor_location");
                  String cat = Hive.box("icousel").get("counsellor_category");
                  // String cgroup = Hive.box("icousel").get("counsellor_group");

                  if (cat == "All Categories") {
                    cat = "";
                  }
                  //if (cat != "") {
                  //  cat = "$cat";
                  // }

                  // print("----------------");
                  // print("${element.cstate} -- $loc");
                  // print("${element.ctype} -- $cat");

                  return element.cstate.contains(loc) &&
                      element.ctype.contains(cat);
                }).toList();

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: counsellors.length,
                    itemBuilder: (BuildContext context, int index) {
                      String newName = counsellors[index].ctype;
                      newName = newName.replaceAll('counsellor', ' ');
                      return Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        // width: double.infinity - 40,
                        height: screenheight * 0.14,
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
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.15,

                            //height: 500,
                            margin: EdgeInsets.symmetric(horizontal: 3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image(
                                image: NetworkImage(
                                    "https://icounselgh.net/default/upload/${counsellors[index].pic}" ??
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          counsellors[index].cname ??
                                              "Counsellor",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        // SizedBox(height: 4),

                                        // Text(newName ?? "Good Counsellor",
                                        //     maxLines: 1,
                                        //     overflow: TextOverflow.ellipsis,
                                        //     style: TextStyle(
                                        //         color: Theme.of(context)
                                        //             .accentColor,
                                        //         fontSize: 9,
                                        //         fontWeight: FontWeight.bold)),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.place,
                                              color:
                                                  Theme.of(context).accentColor,
                                              size: 10,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              counsellors[index].cstate ??
                                                  "Legon",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            // SizedBox(height: 4),
                                          ],
                                        ),
                                        SizedBox(height: 4),

                                        GestureDetector(
                                          onTap: () async {
                                            // Route route = MaterialPageRoute(
                                            //     builder: (c) => BookCounsellor(data: counsellors[index]));
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
                                                  style:
                                                      SweetAlertStyle.confirm,
                                                  showCancelButton: true,
                                                  onPress: (bool isConfirm) {
                                                if (isConfirm) {
                                                  SweetAlert.show(context,
                                                      subtitle: "loading...",
                                                      style: SweetAlertStyle
                                                          .loading);
                                                  new Future.delayed(
                                                      new Duration(seconds: 2),
                                                      () {
                                                    Navigator.of(context).pop();
                                                    Route route =
                                                        MaterialPageRoute(
                                                            builder: (c) =>
                                                                Cform());
                                                    Navigator.push(
                                                        context, route);
                                                  });
                                                } else {
                                                  SweetAlert.show(context,
                                                      subtitle: "Canceled!",
                                                      style: SweetAlertStyle
                                                          .error);
                                                }
                                                // return false to keep dialog
                                                return false;
                                              });
                                            } else if (repo == "done") {
                                              Navigator.of(context).pop();
                                              Route route = MaterialPageRoute(
                                                  builder: (c) =>
                                                      BookCounsellor(
                                                          data: counsellors[
                                                              index]));
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
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              height: 30,
                                              width: 50,
                                              child: Center(
                                                  child: Text(
                                                "Book",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              )),
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
                                      // GestureDetector(
                                      //   onTap: () async {
                                      //     // Route route = MaterialPageRoute(
                                      //     //     builder: (c) => BookCounsellor(data: counsellors[index]));
                                      //     // Navigator.push(context, route);
                                      //     SweetAlert.show(
                                      //       context,
                                      //       title: "Loading ..",
                                      //       subtitle: "Please wait...",
                                      //       style: SweetAlertStyle.loading,
                                      //     );

                                      //     var repo = await cftest();

                                      //     print(repo);

                                      //     if (repo == "new") {
                                      //       // SweetAlert.show(
                                      //       //   context,
                                      //       //   title: "Warning",
                                      //       //   subtitle:
                                      //       //       "   Kindly Navigate to settings to fill Counselling Consent form before  before ",
                                      //       //   style: SweetAlertStyle.error,
                                      //       // );

                                      //       SweetAlert.show(context,
                                      //           subtitle:
                                      //               "Hello!, Kindly complete the consent form to start booking",
                                      //           style: SweetAlertStyle.confirm,
                                      //           showCancelButton: true,
                                      //           onPress: (bool isConfirm) {
                                      //         if (isConfirm) {
                                      //           SweetAlert.show(context,
                                      //               subtitle: "loading...",
                                      //               style: SweetAlertStyle
                                      //                   .loading);
                                      //           new Future.delayed(
                                      //               new Duration(seconds: 2),
                                      //               () {
                                      //             Navigator.of(context).pop();
                                      //             Route route =
                                      //                 MaterialPageRoute(
                                      //                     builder: (c) =>
                                      //                         Cform());
                                      //             Navigator.push(
                                      //                 context, route);
                                      //           });
                                      //         } else {
                                      //           SweetAlert.show(context,
                                      //               subtitle: "Canceled!",
                                      //               style:
                                      //                   SweetAlertStyle.error);
                                      //         }
                                      //         // return false to keep dialog
                                      //         return false;
                                      //       });
                                      //     } else if (repo == "done") {
                                      //       Navigator.of(context).pop();
                                      //       Route route = MaterialPageRoute(
                                      //           builder: (c) => BookCounsellor(
                                      //               data: counsellors[index]));
                                      //       Navigator.push(context, route);
                                      //     } else {
                                      //       SweetAlert.show(
                                      //         context,
                                      //         title: "Warning",
                                      //         subtitle:
                                      //             "   Kindly check your internet connection and try again",
                                      //         style: SweetAlertStyle.error,
                                      //       );
                                      //     }
                                      //   },
                                      //   child: Container(
                                      //       margin: EdgeInsets.only(bottom: 10),
                                      //       height: 40,
                                      //       width: 100,
                                      //       child: Center(
                                      //           child: Text(
                                      //         "Book",
                                      //         style: TextStyle(
                                      //             color: Colors.white,
                                      //             fontSize: 13,
                                      //             fontWeight: FontWeight.bold),
                                      //       )),
                                      //       decoration: BoxDecoration(
                                      //         color:
                                      //             Theme.of(context).accentColor,
                                      //         borderRadius:
                                      //             BorderRadius.circular(12),
                                      //       )),
                                      // ),
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

class Counsellor {
  final int cid;
  final String cname;
  final String cmail;
  final int ccontact;
  final String cstate;
  final String ctype;
  final String counsegroup;
  final String gpcpin;
  final String cstatus;
  final String pic;
  final String bio;
  // final String dateadded;
  Counsellor(
      this.cid,
      this.cname,
      this.cmail,
      this.ccontact,
      this.cstate,
      this.ctype,
      this.counsegroup,
      this.gpcpin,
      this.cstatus,
      this.pic,
      this.bio);
}
