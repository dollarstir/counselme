// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icounselgh/HomePage.dart';
import 'package:icounselgh/cform.dart';
import 'package:icounselgh/choose.dart';
import 'package:icounselgh/counsellorProfilePage.dart';
import 'package:icounselgh/loginPage.dart';
import 'package:icounselgh/models/channel_info.dart';
import 'package:icounselgh/models/viideos_list.dart';
import 'package:icounselgh/screens/video_player_screen.dart';
import 'package:icounselgh/utils/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';
import 'dart:async';
import 'dart:convert';

class Cconnect extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Cconnect> {
  Box hiveBox = Hive.box("icousel");

  String country = "Select Counsellors location";
  String category = "Select Counselling Need";
  String counsellinggp = "Select Counselling group";

  bool selected = false;
  bool selectedloc = false;
  bool selectedgroup = false;
  bool v1 = false;

  // bool v2 = false;
  // bool v3 = false,
  // bool v4 = false,
  //
  var dbval5 = 1;
  var mytpe1;

  bool vis = false;
  bool visi = false;
  bool visii = false;

  @override
  void initState() {
    super.initState();
  }



  showDataAlert(username, image, location, type, bio) {
    type = type.replaceAll(',','\n ◘\t\t');
    showDialog(
        context: context,
        builder: (context) {
          
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),
            title: IconButton(onPressed: (){
              Navigator.of(context).pop();
            }, icon: Icon(Icons.close,color: Colors.red,)),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.width * 0.45,

                          //height: 500,
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image(
                              image: NetworkImage(
                                  "https://icounselgh.net/main/default/upload/$image" ??
                                      "assets/images/counsellor1.jpeg"),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Text('${username}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left:25),
                      margin: EdgeInsets.only(left: 20,top:10),
                      child: Center(child: Row(
                        children: [
                          Icon(
                            Icons.place,
                            color: Theme.of(context).accentColor,
                            size: 15,
                          ),
                          SizedBox(width: 7),
                          Text(location,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(child: Text('\t◘  ${type}')),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left:30,right:30,top:20,bottom: 30),
                      child: Center(child: Text('${bio}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:
          //  AppBar(
          //   title: Text(_loading ? 'Loading...' : 'YouTube'),
          // ),

          PreferredSize(
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
                'COUNSELLOR',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                ' CONNECT',
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // _buildInfoView(),
            Expanded(
              flex: 1,
              child: Container(
                // padding:EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  //  color: Colors.blue,
                ),
                width: screenwidth,
                height: screenheight * 0.41,
                child: Container(
                  // color: Colors.blue,
                  padding: EdgeInsets.only(top: 2, right: 20, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Counsellor Connect services match you to licensed counsellors who best fit your counselling need. Our licensed professional counsellors are ready to assist you anytime and anywhere. You can search for a counsellor by name, location, target group and your counselling need.',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Get connected now.',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfffaab3b),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: screenheight * 0.05,
                      width: screenwidth * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            // offset: Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Center(
                        child: DropdownButton(
                          value: dbval5,
                          items: [
                            DropdownMenuItem(
                              child: Text("Search Counsellor by? "),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("Counsellors Name"),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text("Counselling Need"),
                              value: 3,
                            ),
                            DropdownMenuItem(
                              child: Text("Counsellor's Location"),
                              value: 4,
                            ),
                            DropdownMenuItem(
                              child: Text("Counselling group"),
                              value: 5,
                            ),
                          ],
                          onChanged: (int val) {
                            setState(() {
                              dbval5 = val;
                            });
                            if (val == 1) {
                              setState(() {
                                mytpe1 = "";
                                v1 = false;
                                vis = false;
                                visi = false;
                                visii = false;
                              });
                            } else if (val == 2) {
                              setState(() {
                                mytpe1 = "Counsellors Name";
                                v1 = true;
                                vis = false;
                                visi = false;
                                visii = false;
                              });
                            } else if (val == 3) {
                              setState(() {
                                mytpe1 = "Counselling Need";
                                v1 = false;
                                vis = true;
                                visi = false;
                                visii = false;
                              });
                            } else if (val == 4) {
                              setState(() {
                                mytpe1 = "Counsellor's Location";
                                v1 = false;
                                vis = false;
                                visi = true;
                                visii = false;
                              });
                            } else if (val == 5) {
                              setState(() {
                                mytpe1 = "Counselling group";
                                v1 = false;
                                vis = false;
                                visi = false;
                                visii = true;
                              });
                            }
                          },
                          hint: Text("Search counsellor by? "),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Visibility(
                      visible: v1,
                      child: CustomSearchTextField(
                        onChanged: (String value) {
                          //selected = true;
                          String name = value.toLowerCase();
                          // print(category);
                          hiveBox.put("counsellor_name", name);
                        },
                        data: Icons.search,
                        isObsecure: false,
                        hintText: "Enter  counsellor's name...",
                      ),
                    ),
                    Visibility(
                      visible: vis,
                      child: ChooseCategory(
                          categories: [
                            'Select Counselling Need',
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
                              if (category == 'Select Counselling Need') {
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
                    ),
                    Visibility(
                      visible: visi,
                      child: ChooseLocation(
                          countries: [
                            'Select Counsellors location',
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
                              if (country == 'Select Counsellors location') {
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
                    ),
                    Visibility(
                      visible: visii,
                      child: ChooseGroup(
                          groups: [
                            'Select Counselling group',
                            'Child and Adolescent',
                            'Religious',
                            'School',
                            'Adult and Aged',
                            'Corporate',
                            'Community'
                          ],
                          group: counsellinggp,
                          selectedgroup: selectedgroup,
                          onChanged: (val) {
                            setState(() {
                              //selected = true;
                              counsellinggp = val;
                              // print(category);
                              if (counsellinggp == 'Select Counselling group') {
                                hiveBox.put("counsellor_group", "");
                                selectedgroup = false;
                                // print(selected);
                              } else {
                                hiveBox.put("counsellor_group", val);
                                selectedgroup = true;
                                // print(selected);
                              }
                            });
                          }),
                    ),
                    SizedBox(height: 8),
                    Expanded(child: CounsellorTile1()),
                    SizedBox(height:10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CounsellorTile1 extends StatelessWidget {
  var cid;
  String name;
  String type;
  String location;
  String image;
  Function cardAction;

  CounsellorTile1({this.cid, this.name, this.type, this.location, this.image, this.cardAction,});


  showDataAlert(context, username, image, location, type, bio) {
    type = type.replaceAll(',','\n ◘\t\t');
    showDialog(
        context: context,
        builder: (context) {
          
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),
            title: IconButton(onPressed: (){
              Navigator.of(context).pop();
            }, icon: Icon(Icons.close,color: Colors.red,)),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.width * 0.45,

                          //height: 500,
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image(
                              image: NetworkImage(
                                  "https://icounselgh.net/main/default/upload/$image" ??
                                      "assets/images/counsellor1.jpeg"),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Text('${username}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left:25),
                      margin: EdgeInsets.only(left: 20,top:10),
                      child: Center(child: Row(
                        children: [
                          Icon(
                            Icons.place,
                            color: Theme.of(context).accentColor,
                            size: 15,
                          ),
                          SizedBox(width: 7),
                          Text(location,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(child: Text('\t◘  ${type}')),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left:30,right:30,top:20,bottom: 30),
                      child: Center(child: Text('${bio}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

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
      margin: EdgeInsets.only(top: 1),
      child: StreamBuilder(
        stream: Hive.box("icousel").watch(),
        builder: (context, data) => FutureBuilder(
            future: Getcounsellor1(),
            builder: (context, snapshot) {
            
              switch (snapshot.connectionState) {

                case ConnectionState.waiting :
                  return ShimmerList();
                  break;
                case ConnectionState.active:
                  return ShimmerList();
                  
                  break;
                case ConnectionState.done:
                  if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: ShimmerList(),
                  ),
                );
              } else {
                List<Counsellor> counsellorm = snapshot.data;

                counsellorm = counsellorm.where((element) {
                  String loc = Hive.box("icousel").get("counsellor_location");
                  String cat = Hive.box("icousel").get("counsellor_category");
                  String name = Hive.box("icousel").get("counsellor_name");
                  String cgroup = Hive.box("icousel").get("counsellor_group");

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
                      element.counsegroup.contains(cgroup) &&
                      element.ctype.contains(cat) &&
                      element.cname.toLowerCase().contains(name);
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
                        // height: screenheight * 0.18,
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
                              child: InkWell(
                                onTap: () {
                                  showDataAlert(
                                    context,
                                    counsellorm[index].cname, 
                                    counsellorm[index].pic, 
                                    counsellorm[index].cstate, 
                                    counsellorm[index].ctype, 
                                    counsellorm[index].bio,
                                  );
                                },
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
                                            counsellorm[index].cname ??
                                                "Counsellor",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 4),
                                          Text(newName ?? "Good Counsellor",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              //softWrap: true,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
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
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                          // SizedBox(height: 4),
                                          // Text(counsellorm[index].gpcpin ?? "",
                                          //     maxLines: 1,
                                          //     overflow: TextOverflow.ellipsis,
                                          //     //softWrap: true,
                                          //     style: TextStyle(
                                          //         color: Theme.of(context)
                                          //             .accentColor,
                                          //         fontSize: 10,
                                          //         fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    Row(
                              
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // SizedBox(height: 4),
                                          Text(counsellorm[index].gpcpin ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              //softWrap: true,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                        Container(
                                          // width: 111,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            // print("Book");
                                            // return;
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
                                                      style:
                                                          SweetAlertStyle.error);
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
                                            margin: EdgeInsets.only(
                                                bottom: 10, right: 10),
                                            height: 30,
                                            width: 100,
                                            // margin: EdgeInsets.only(),
                                            child: Center(
                                                child: Text(
                                              "Book",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).accentColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                      );
                    });
              }
              break;
                default:
              }
            }),
      ),
    );
  }



}

class ListItem extends StatelessWidget {
  final int index;
  const ListItem({Key key, this.index});  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            margin: EdgeInsets.only(right: 15.0),
            color: Colors.blue,
          ),
          index != -1
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'This is title $index',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('This is more details'),
                    Text('One more detail'),
                  ],
                )
              : Expanded(
                  child: Container(
                    color: Colors.grey,
                  ),
                )
        ],
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  final int itemCount;

  const ShimmerList({Key key, this.itemCount = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
              itemCount: 10,
              // Important code
              itemBuilder: (context, index) => Shimmer.fromColors(
                  baseColor: Colors.grey[400],
                  highlightColor: Colors.white,
                  child: ListItem(index: -1)),
            );
  }
}

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
     
    );
  }
}

class Item extends StatelessWidget {
  final Color color;

  const Item({
    Key key,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 140,
            color: color,
            margin: EdgeInsets.only(bottom: 10),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 8.0,
                  color: color,
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Container(
                  width: 40.0,
                  height: 8.0,
                  color: color,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}