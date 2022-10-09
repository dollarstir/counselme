import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class Mnotify extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<Mnotify> {
  @override
  Widget build(BuildContext context) {
     double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight( screenheight * 0.2),
        child: AppBar(
           backgroundColor: Color(0xfffaab3b),
          centerTitle: true,
          title: Container(
            // padding:EdgeInsets.only(top: screenheight * 0.04),
            child: Text("Notifications",style: GoogleFonts.montserrat(
                       ),),
          ),
          // backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 20),
            QuoteTile(),
          ],
        )),
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
      String blurl = "https://icounselgh.net/mnotify";
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
