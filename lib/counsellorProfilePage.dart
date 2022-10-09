import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'activity.dart';
import 'package:intl/intl.dart';

import 'HomePage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

import 'notifications.dart';
// import 'package: intl.intl.dart';

class BookCounsellor extends StatefulWidget {
  final Counsellor data;

  BookCounsellor({@required this.data});

  @override
  _BookCounsellorState createState() => _BookCounsellorState();
}

class _BookCounsellorState extends State<BookCounsellor> {
  TextEditingController _region = TextEditingController();
  TextEditingController _type = TextEditingController();
  bool dateSeleted = false;
  bool timeSeleted = false;
  bool clicked = false;
  int date4;
  String date5;
  String date6;
  void _hideResult() {
    setState(() {
      clicked = false;
    });
  }

  var mycid;

  // alert to show counsellor Details
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
  void initState() {
    setState(() {
      mycid = widget.data.cid;
    });
    print(mycid);
    super.initState();
  }

  var date2;
  var date3 = "";

  Future Bookings() async {
    Box box = Hive.box("icousel");
    var stt = box.get("ustate");
    var userid = box.get("userid");
    print(date3);
    print(date2);

    String bookurl = "https://icounselgh.net/book";
    var response = await http.post(Uri.parse(bookurl), body: {
      "userid": userid,
      "cid": mycid.toString(),
      "cname": widget.data.cname,
      "ctype": widget.data.ctype,
      "clocation": widget.data.cstate,
      "userlocation": stt,
      "appdate": date2,
      "apptime": date3,
      "status": "pending",
      "cpic": widget.data.pic.toString(),
      "ccontact": widget.data.ccontact.toString(),
    });
    var result = jsonDecode(response.body);
    print(result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking ${widget.data.cname}"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 70),
              GestureDetector(
                onTap: () {
                  showDataAlert(widget.data.cname, widget.data.pic,
                      widget.data.cstate, widget.data.ctype, widget.data.bio);
                },
                child: CounsellorTile(
                  cid: widget.data.cname,
                  image: widget.data.pic,
                  name: widget.data.cname,
                  location: widget.data.cstate,
                  type: widget.data.ctype,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Container(
                  child: Text(""),
                  color: Colors.blue,
                ),
              ),
              FlatButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        maxTime: DateTime(DateTime.now().year + 9, 12, 31),
                        theme: DatePickerTheme(
                            cancelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            headerColor: Colors.orange,
                            backgroundColor: Colors.grey[200],
                            itemStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        onChanged: (date) {
                      print('change $date in time zone ' +
                          date.timeZoneOffset.inHours.toString());
                      // Text("You have scheduled a meeting on $date");
                    }, onConfirm: (date) {
                      print('confirm $date');
                      setState(() {
                        // print(date.day);
                        //                         print(date.hour);
                        //                                                 print(date.minute);

                        // date4 = date.day;
                        var date5 = date;

                        var format = DateFormat.yMMMMEEEEd().format(date5);

                        date2 = format.toString();
                        dateSeleted = true;
                      });
                      //Text("You have scheduled a meeting on $date");
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'Schedule a date',
                    style: TextStyle(color: Colors.white),
                  )),
              FlatButton(
                  color: dateSeleted
                      ? Theme.of(context).accentColor
                      : Colors.grey[300],
                  onPressed: () {
                    dateSeleted
                        ? DatePicker.showTime12hPicker(context,
                            theme: DatePickerTheme(
                                cancelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                headerColor: Colors.orange,
                                backgroundColor: Colors.grey[200],
                                itemStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                doneStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            showTitleActions: true, onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                            // Text("You have scheduled a meeting on $date");
                            // Scaffold.of(context).showSnackBar(SnackBar(
                            //     content:
                            //         Text("You have scheduled a meeting on $date")));
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: const Text('A SnackBar has been shown.'),
                            //   ),
                            // );
                          }, onConfirm: (time) {
                            print('confirm $time');
                            //Text("You have scheduled a meeting on $date");
                            setState(() {
                              var date6 = time;

                              var format = DateFormat.jm().format(date6);
                              date3 = format.toString();
                              //date3 = time;
                              timeSeleted = true;
                            });
                          }, currentTime: DateTime.now())
                        : setState(() {
                            clicked = true;
                          });
                    Timer(Duration(seconds: 2), () {
                      _hideResult();
                    });
                  },
                  child: Text(
                    'Select a convenient time',
                    style: TextStyle(color: Colors.white),
                  )),
              AnimatedOpacity(
                child: Text(
                  "Please schedule a date first",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                opacity: clicked ? 1 : 0,
                duration: Duration(seconds: 1),
              ),
              //Opacity(opacity: opacity)
              // Text(dateSeleted
              //     ? "You have scheduled a meeting on " + date2.toString()
              //     : ""),
              Container(
                padding: EdgeInsets.all(20),
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: dateSeleted
                          ? "You have scheduled a meeting on " +
                              date2.toString()
                          : "",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: timeSeleted ? " at " + date3.toString() : "",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ])),
              ),
              SizedBox(height: 30),

              GestureDetector(
                onTap: () async {
                  SweetAlert.show(
                    context,
                    title: "Loading ..",
                    subtitle: "Please wait...",
                    style: SweetAlertStyle.loading,
                  );
                  // print(date2.toString());
                  if (date3 == "") {
                    Navigator.of(context).pop();
                    SweetAlert.show(
                      context,
                      title: "Sorry",
                      subtitle: "Select  appropriate time ",
                      style: SweetAlertStyle.error,
                    );
                  } else {
                    var rep = await Bookings();

                    // print(rep);
                    if (rep == "all field required") {
                      // Navigator.of(context).pop();
                      SweetAlert.show(
                        context,
                        title: "Sorry",
                        subtitle: "Select date and time",
                        style: SweetAlertStyle.error,
                      );
                    } else if (rep == "You already booked this counsellor") {
                      //  Navigator.of(context).pop();
                      SweetAlert.show(
                        context,
                        title: "Sorry",
                        subtitle: "Counsellor Already booked",
                        style: SweetAlertStyle.error,
                      );
                    } else if (rep == "booked") {
                      creatNotification(
                          'You request for ${widget.data.cname} has been duely logged.',
                          widget.data.pic);
                      SweetAlert.show(
                        context,
                        title: "Congrats!!",
                        subtitle: 'Your request is being proccessed',
                        style: SweetAlertStyle.success,
                      );

                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.of(context).pop();
                        Route route =
                            MaterialPageRoute(builder: (c) => HomeScreen());
                        Navigator.pushReplacement(context, route);
                      });
                    } else {
                      SweetAlert.show(
                        context,
                        title: 'Sorry',
                        subtitle: 'Failed to book counsellor',
                        style: SweetAlertStyle.error,
                      );
                    }
                  }
                },
                child: Container(
                    //padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(10),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              )
              // Container(
              //   margin: EdgeInsets.all(10),
              //   height: 50,
              //   width: double.infinity,
              //   child: Center(
              //     child: Text(
              //       "Next",
              //       style: TextStyle(
              //           color: Colors.white, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).accentColor,
              //     borderRadius: BorderRadius.all(Radius.circular(10)),
              //   ),
              // ),
            ]),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;

  CustomTextField(
      {Key key, this.controller, this.data, this.hintText, this.isObsecure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            //border: InputBorder.none,
            focusColor: Theme.of(context).primaryColor,
            hintText: hintText ?? "input",
            prefixIcon: Icon(data, color: Theme.of(context).primaryColor)),
      ),
    );
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

    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      // padding: EdgeInsets.only(right: 10),
      width: double.infinity - 40,
      height: screenheight * 0.19,
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            offset: Offset(0, 5), color: Colors.grey[200], blurRadius: 10),
      ], borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Stack(overflow: Overflow.visible, children: [
        Positioned(
          left: 20,
          bottom: 40,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,

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
        SizedBox(width: 6),
        Positioned(
          left: 160,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          name ?? "Counsellor",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(type ?? "Good Counsellor",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.place,
                            color: Theme.of(context).accentColor,
                            size: 15,
                          ),
                          SizedBox(width: 5),
                          Text(location ?? "Legon",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        ],
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
                    //   onTap: () {},
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
                    //         color: Theme.of(context).accentColor,
                    //         borderRadius: BorderRadius.circular(12),
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
  }
}

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}
