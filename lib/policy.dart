import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
class Tanc extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Tanc> {

  bool agreed ;
    @override
    void initState() {
      super.initState();
      var mybox =  Hive.box('icousel');
    var isagreed =  mybox.get("isagreed");
    setState(() {
      agreed =isagreed;
    });
      
      
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "TERMS AND CONDITIONS",
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
                top: 30,
              ),
              child: Center(
                child: Column(
                  children: [
                    // Text(" TERMS AND CONDITIONS",style: GoogleFonts.montserrat(
                    //                 fontSize: 20, fontWeight: FontWeight.w500),),
                    // SizedBox(height: 10),
                    Text(
                      " ONLINE COUNSELLING SERVICES",
                      style: GoogleFonts.montserrat(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),

                    //  Text("The following terms and conditions upon acceptance by the Client will regulate the Counsellor/Client relationship on this platform.", style: GoogleFonts.montserrat(
                    //                 fontSize: 13, fontWeight: FontWeight.w500),),

                    //  Text("1. The Therapist gives no guarantee that the provision of the service will result in an improvement to the Client’s mental or physical condition and general wellbeing as each individual Client reacts in a different manner to therapy and it may be necessary for a Client to undergo an extended period of therapy before any improvement may be apparent if at all. \n 2.The therapist warrants to keep all information confidential save for clinical supervision and where the Therapist is required by law and for strong moral obligation to disclose some material facts to a third party \n 3. We warrant to keep the personal details of every Client confidential however Clients may choose to remain anonymous in which case will not negate the Counsellor/Client relationship and/ or all other services incidental to that relationship. \n 4. We warrant that every Counsellor providing Counsellor Services on this platform is an accredited, trained, and experienced licensed psychologist (PhD / PsyD), licensed marriage and family therapist (LMFT), licensed clinical social worker (LCSW), licensed professional counsellor (LPC), or similar applicable recognized professional certification based on the regulations of Ghana or the  Ghana Counsellors Association.  \n 5. This platform is not intended for the provision of clinical diagnosis requiring an in-person evaluation and you should not use it if you need any official documentation or approvals for purposes such as, but not limited to, court-ordered counselling or emotional service dog certification. It is also not intended for any information regarding which drugs or medical treatment may be appropriate for you, and you should disregard any such advice if delivered through the platform. \n 6. Do not disregard, avoid, or delay in obtaining in-person care from your doctor or other qualified professional because of information or advice you received through the platform. \n 7. You hereby release us and agree to hold us harmless from any and all causes of action and claims of any nature resulting from the counsellor services or the platform, including (without limitation) any act, omission, opinion, response, advice, suggestion, information and/or service of any counsellor and/or any other content or information accessible through the platform.  \n 8. You understand, agree and acknowledge that the platform is provided 'as is' without any express or implied warranties of any kind, including but not limited to merchantability, non-infringement, security, fitness for a particular purpose or accuracy. The use of the platform is at your own risk to the fullest extent of the law, we expressly disclaim all warranties of any kind, whether expressed or implied. \n 9. You understand, agree and acknowledge that we shall not be liable to you or to any third party for any indirect, incidental, consequential, special, punitive or exemplary damages.",style:GoogleFonts.montserrat(
                    //                 fontSize: 12, fontWeight: FontWeight.w500),),

                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            // Container(
                            //   child: Text("SECURITY", style: GoogleFonts.montserrat(
                            //         fontSize: 20, fontWeight: FontWeight.w500),),
                            // ),
                            Text(
                              "The following terms and conditions upon acceptance by the Client will regulate the Counsellor/Client relationship on this platform.",
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                  "1. The Therapist gives no guarantee that the provision of the service will result in an improvement to the Client’s mental or physical condition, and general wellbeing as each individual Client reacts in a different manner to therapy, and it may be necessary for a Client to undergo an extended period of therapy before any improvement may be apparent if at all. \n  \n 2.The Therapist warrants to keep all information confidential and safe for clinical supervision, and where the Therapist is required by law and for strong moral obligation to disclose some material facts to a third party. \n \n 3. We warrant to keep the personal details of every Client confidential, however Clients may choose to remain anonymous in which case will not negate the Counsellor/Client relationship and/ or all other services incidental to that relationship. \n \n 4. We warrant that every Counsellor providing Counselling Services on this platform is an accredited, trained, and experienced licensed psychologist (PhD / PsyD), licensed marriage and family therapist (LMFT), licensed clinical social worker (LCSW), licensed professional counsellor (LPC), or similar applicable recognized professional certification based on the regulations of Ghana or the  Ghana Counsellors Association.  \n \n 5. This platform is not intended for the provision of clinical diagnosis requiring an in-person evaluation, and you should not use it if you need any official documentation or approvals for purposes such as, but not limited to, court-ordered counselling or emotional service dog certification. It is also not intended for any information regarding which drugs or medical treatment may be appropriate for you, and you should disregard any such advice if delivered through the platform. \n \n 6. Do not disregard, avoid, or delay in obtaining in-person care from your doctor or other qualified professional because of information or advice you received through the platform. \n \n 7. You hereby release us and agree to hold us harmless from any and all causes of action and claims of any nature resulting from the counsellor's services or the platform, including (without limitation) any act, omission, opinion, response, advise, suggestion, information and/or service of any counsellor and/or any other content or information accessible through the platform.  \n \n 8. You understand, agree and acknowledge that the platform is provided 'as is' without any express or implied warranties of any kind, including but not limited to merchantability, non-infringement, security, fitness for a particular purpose or accuracy. The use of the platform is at your own risk to the fullest extent of the law, we expressly disclaim all warranties of any kind, whether expressed or implied. \n \n 9. You understand, agree and acknowledge that we shall not be liable to you or to any third party for any indirect, incidental, consequential, special, punitive or exemplary damages.",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.justify),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ), //SizedBox
                                Text(
                                  'Agree to terms and conditions ',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ), //Text
                                SizedBox(width: 5), //SizedBox
                                /** Checkbox Widget **/
                                Checkbox(
                                  value: agreed,
                                  onChanged: (bool value) {
                                    setState(() {
                                      agreed = value;
                                    });
                                  },
                                ), //Checkbox
                              ], //<Widget>[]
                            ),
                            SizedBox(height: 5),
                            // Visibility(
                            //   visible: agreed,
                            //   child: GestureDetector(
                            //     onTap: () async {},
                            //     child: Container(
                            //         //padding: EdgeInsets.all(20),
                            //         margin: EdgeInsets.all(10),
                            //         height: 50,
                            //         width: double.infinity,
                            //         child: Center(
                            //           child: Text(
                            //             "Continue",
                            //             style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //         ),
                            //         decoration: BoxDecoration(
                            //           color: Theme.of(context).accentColor,
                            //           borderRadius:
                            //               BorderRadius.all(Radius.circular(10)),
                            //         )),
                            //   ),
                            // ),
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
