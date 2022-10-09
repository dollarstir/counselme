import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          " Security",
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
                top: 50,
              ),
              child: Center(
                child: Column(
                  children: [
                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text("SECURITY", style: GoogleFonts.montserrat(
                                    fontSize: 20, fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 15,right: 15,top: 5),
                              child: Text(
                                  "Counsel-Me has been built in a well-structured technology systems, operation, and infrastructure with your privacy in mind. You can feel safe and comfortable because the following conditions have been embedded in the App to ensure your privacy.",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.justify
                                  ),
                            ),
                            SizedBox(height: 10),
                            new ListTile(
                              leading: new MyBullet(),
                              title: new Text('Everything you tell your counsellor is protected because they have taken an oath to protect you.'
                              ,
                              style: GoogleFonts.montserrat(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                            new ListTile(
                              leading: new MyBullet(),
                              title: new Text('Your counsellors are not in alliance with any agency that may require your records.'
                              ,
                              style: GoogleFonts.montserrat(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),

                            new ListTile(
                              leading: new MyBullet(),
                              title: new Text('All the messages between you and your counsellor are secured and encrypted. ',
                              style: GoogleFonts.montserrat(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                            new ListTile(
                              leading: new MyBullet(),
                              title: new Text('Our browsing encryption system (SSL) follows modern best practices, providing world class online security and encryption.',
                              style : GoogleFonts.montserrat(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                            new ListTile(
                              leading: new MyBullet(),
                              title: new Text('Our databases are encrypted and scrambled so they essentially become useless in the very unlikely event that they are being stolen or inappropriately used.',
                              style: GoogleFonts.montserrat(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),

                            new ListTile(
                              leading: new MyBullet(),
                              title: new Text('No one will record your counselling session.',
                              style: GoogleFonts.montserrat(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                            new ListTile(
                              leading: new MyBullet(),
                              title: new Text('You have the freedom to ask any question that bothers your privacy as you use the system.',
                              style: GoogleFonts.montserrat(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
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
