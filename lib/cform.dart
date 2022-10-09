import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icounselgh/HomePage.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'loginPage.dart';

class Cform extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

enum Response { Yes, No }

class _FaqState extends State<Cform> {
  Response _site = Response.Yes;
  Response _to = Response.Yes;
  Response _tre = Response.Yes;
  Response _fo = Response.Yes;
  Response _fi = Response.Yes;
  Response _si = Response.Yes;
  Response _sev = Response.Yes;
  Response _et = Response.Yes;
  Response _ni = Response.Yes;

  Future cform() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    var userlink = "https://icounselgh.net/cform";
    var response = await http.post(
      Uri.parse(userlink),
      body: {
        'id': userid,
        'a1': _site.toString(),
        'a2': _to.toString(),
        'a3': _tre.toString(),
        'a4': _fo.toString(),
        'a5': _fi.toString(),
        'a6': _si.toString(),
        'a7': _sev.toString(),
        'a8': _et.toString(),
        'a9': _ni.toString(),
      },
    );
    var result = jsonDecode(response.body);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Consent Form",
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
                    SizedBox(height: 10),
                    Text("  COUNSELLING CONSENT FORM"),
                    SizedBox(height: 10),
                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text("INTRODUCTION",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  )),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                  "Welcome to TUCEE iCounsel-Gh session. You are a cherished friend of TUCEE and associates. iCounsel-Gh session involves counselling process designed to help you gain a greater understanding of yourself and environment towards making informed decisions. The outcome of counselling is often positive; however, the level of satisfaction for any individual is not predictable. Your counsellor is available to support you throughout the counselling process"),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                  "DO YOU WISH TO GIVE YOUR CONSENT FOR THIS COUNSELLING PLEASE?"),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Yes"),
                                    leading: Radio(
                                      value: Response.Yes,
                                      groupValue: _site,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _site = value;
                                        });
                                        print(_site);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("No"),
                                    leading: Radio(
                                      value: Response.No,
                                      groupValue: _site,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _site = value;
                                        });
                                        print(_site);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text("CONSENT TO TREATMENT"),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                  "I voluntarily consent to this counselling relationship at any time to allow counselling services, assessments, and treatments for myself and any other related person, when applicable. The licensed professional counsellor may consult with other counsellors or psychologists in order to better conceptualize my case. Successful termination of services is determined when the counsellor and I agree that the treatment goals are substantially completed."),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Yes"),
                                    leading: Radio(
                                      value: Response.Yes,
                                      groupValue: _to,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _to = value;
                                        });
                                        print(_to);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("No"),
                                    leading: Radio(
                                      value: Response.No,
                                      groupValue: _to,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _to = value;
                                        });
                                        print(_to);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                  "SENSITIVE INFORMATION AND CONFIDENTIALITY"),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                  "I accept that the extent of my recovery depends on my willingness to provide adequate and accurate information. In the counselling process, I may need to share sensitive, personal, and private information that may at times be distressing. I am assured by my counsellor that all this information shall be treated as confidential, and will only be used to facilitate my recovery and nothing else. However, I may request in writing that my counsellor releases specific information about my counselling issues to persons I designate."),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Yes"),
                                    leading: Radio(
                                      value: Response.Yes,
                                      groupValue: _tre,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _tre = value;
                                        });
                                        print(_tre);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("No"),
                                    leading: Radio(
                                      value: Response.No,
                                      groupValue: _tre,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _tre = value;
                                        });
                                        print(_tre);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text("EXCEPTIONS TO CONFIDENTIALITY"),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                  "I accept that my counsellor may consult with other counsellors or refer me to them to provide the best possible care. In such cases, my counsellor may brief the other counsellor(s) about the area where their help would be needed."),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Yes"),
                                    leading: Radio(
                                      value: Response.Yes,
                                      groupValue: _fo,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _fo = value;
                                        });
                                        print(_fo);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("No"),
                                    leading: Radio(
                                      value: Response.No,
                                      groupValue: _fo,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _fo = value;
                                        });
                                        print(_fo);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text("EXCEPTIONS TO CONFIDENTIALITY"),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                  "I accept that if there is evidence of clear and imminent danger of harm to myself and/or others, my counsellor is legally required to report this information to the authorities responsible for ensuring safety, but this will be done with my consent. Unless otherwise my rationality is debilitated. "),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Yes"),
                                    leading: Radio(
                                      value: Response.Yes,
                                      groupValue: _fi,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _fi = value;
                                        });
                                        print(_fi);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("No"),
                                    leading: Radio(
                                      value: Response.No,
                                      groupValue: _fi,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _fi = value;
                                        });
                                        print(_fi);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text("EXCEPTIONS TO CONFIDENTIALITY"),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                  "I accept that a court order, issued by a judge, may require my counsellor to release information contained in my records and/or require a counsellor to testify in a court hearing, but this will be done with my consent. Unless otherwise my rationality is debilitated."),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Yes"),
                                    leading: Radio(
                                      value: Response.Yes,
                                      groupValue: _si,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _si = value;
                                        });
                                        print(_si);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("No"),
                                    leading: Radio(
                                      value: Response.No,
                                      groupValue: _si,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _si = value;
                                        });
                                        print(_si);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text("FEES FOR SESSION"),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                  "I understand that there are fees for professional services provided, and that these fees shall be discussed with me. I accept responsibility for the charges incurred. Payment is due at time of services unless arrangements have been made. I accept that my appointment shall be terminated in case I show disloyalty in payment.  I understand and accept that if I fail to pay for the services rendered, my name and details shall be published."),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Yes"),
                                    leading: Radio(
                                      value: Response.Yes,
                                      groupValue: _sev,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _sev = value;
                                        });
                                        print(_sev);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("No"),
                                    leading: Radio(
                                      value: Response.No,
                                      groupValue: _sev,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _sev = value;
                                        });
                                        print(_sev);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child:
                                  Text("ATTENDANCE AND CANCELLATION POLICY "),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                  "We appreciate prompt response for appointments. Please notify us if you will be late. If you need to cancel or reschedule an appointment, please notify us via 0541 69429 or 0244996991 at least 24-hours in advance. The 24-hour notice of cancellation allows us to use the time for other clients. I accept that all appointments cancelled or missed with less than 24 hours notification shall attract a fee. "),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Yes"),
                                    leading: Radio(
                                      value: Response.Yes,
                                      groupValue: _et,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _et = value;
                                        });
                                        print(_et);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("No"),
                                    leading: Radio(
                                      value: Response.No,
                                      groupValue: _et,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _et = value;
                                        });
                                        print(_et);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 7,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text("FINALLY"),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                  "I HAVE READ AND DISCUSSED THE ABOVE INFORMATION WITH MY THERAPIST. I UNDERSTAND THE BENEFITS AND RISKS OF COUNSELLING, THE NATURE AND LIMITS OF CONFIDENTIALITY, AND WHAT IS EXPECTED OF ME AS A CLIENT OF THE COUNSELLING SERVICES."),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Yes"),
                                    leading: Radio(
                                      value: Response.Yes,
                                      groupValue: _ni,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _ni = value;
                                        });
                                        print(_ni);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("No"),
                                    leading: Radio(
                                      value: Response.No,
                                      groupValue: _ni,
                                      onChanged: (Response value) {
                                        setState(() {
                                          _ni = value;
                                        });
                                        print(_ni);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        SweetAlert.show(
                          context,
                          title: "Loading ..",
                          subtitle: "Please wait...",
                          style: SweetAlertStyle.loading,
                        );

                        var repo = await cform();

                        if (repo == "alreadysent") {
                          SweetAlert.show(
                            context,
                            title: "Warning",
                            subtitle: "Your request already submitted",
                            style: SweetAlertStyle.error,
                          );
                        } else if (repo == "sent") {
                          SweetAlert.show(
                            context,
                            title: "Congrats!",
                            subtitle:
                                "Your consent form is submitted successfully.",
                            style: SweetAlertStyle.success,
                          );
                          // print(resp);

                          Future.delayed(Duration(seconds: 4), () {
                            Navigator.of(context).pop();
                            Route route =
                                MaterialPageRoute(builder: (c) => HomeScreen());
                            Navigator.pushReplacement(context, route);
                          });
                        } else if (repo == "failed") {
                          SweetAlert.show(
                            context,
                            title: "Warning",
                            subtitle: "Failed to submit form",
                            style: SweetAlertStyle.error,
                          );
                        }
                      },
                      // textColor: Colors.white,
                      // padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFFFF7d33),
                              Color(0xFFFFbb33),
                              Color(0xFFFFe033),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text('SUBMIT FORM'),
                      ),
                    ),
                    SizedBox(height: 10),
                    
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
