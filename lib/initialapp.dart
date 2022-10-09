import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './activity.dart';
import 'initialterms.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class InitialApp extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<InitialApp> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isallowed) {
      if (!isallowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Allow Notifications'),
                  content: Text('Yolk will like to send you notifications'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Don\'t Allow',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )),
                    TextButton(
                        onPressed: () {
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((_) {
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          'Allow',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ));
      }
    });

    AwesomeNotifications().actionStream.listen((notifications){
      if(notifications.channelKey == "baisc_channel"){
        AwesomeNotifications().getGlobalBadgeCounter().then((value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
      }
      // Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder :(_) => Activity(),),(route)=> route.isFirst);
    });
    
  }

    @override
  void dispose() {
    // TODO: implement dispose
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     "About  Counsel-Me  App",
      //     style: TextStyle(color: Colors.orange),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        // color: Color(0xfffaab3b),
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.30,
                        child: Image(
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Card(
                        elevation: 7,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            children: [
                              Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                  "Counsel-Me is a cyber counselling modality designed to make counselling services available to anyone, anywhere and anytime via calls, chat, sms and more.\n\n This counselling modality brings your counsellor to you as soon as you place a call or send a message. Remember that your counsellor is a click away. \n  Make a call to 0208-496-496 \nSend e-mail to icounselgh.org@gmail.com. \n\n App Version : 1.1.0",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify),
                            ),
                              // SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      GestureDetector(
                        onTap: () async {
                           Route route = MaterialPageRoute(builder: (c) => InitialTanx());
                             Navigator.push(context, route);
                        },
                        child: Container(
                            //padding: EdgeInsets.all(20),
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    ],
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
