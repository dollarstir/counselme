import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutApp extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "About  Counsel-Me  App",
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
                top: 0,
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      // color: Color(0xfffaab3b),
                      width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.37,
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
                                  "Counsel-Me simply believes that distance and time must not be a hindrance to accessing quality and professional counselling services. Counsel-Me is a cyber counselling modality designed to make counselling services available to anyone, anywhere and anytime via your computer, tablet, mobile phone, telephone or smartphone.\n\n This counselling modality brings your counsellor to you as soon as you place a call or send a message. Remember that your counsellor is a click away. \n  Make a call to 0208-496-496 \nSend e-mail to icounselgh.org@gmail.com. \n\n App Version : 1.1.0",
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
                    // GestureDetector(
                    //   onTap: () async {},
                    //   child: Container(
                    //       //padding: EdgeInsets.all(20),
                    //       margin: EdgeInsets.all(10),
                    //       height: 50,
                    //       width: double.infinity,
                    //       child: Center(
                    //         child: Text(
                    //           "Continue",
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //       decoration: BoxDecoration(
                    //         color: Theme.of(context).accentColor,
                    //         borderRadius: BorderRadius.all(Radius.circular(10)),
                    //       )),
                    // ),
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
