import 'package:flutter/material.dart';
import 'package:icounselgh/HomePage.dart';
import 'package:icounselgh/notifications.dart';

import 'SignUpPage2.dart';
import 'loginPage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/percent_indicator.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

class NewCounsellor extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<NewCounsellor> {
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _gender = TextEditingController();

  TextEditingController _dateOfBirth = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _region = TextEditingController();

  TextEditingController _password = TextEditingController();
  TextEditingController _gpcpin = TextEditingController();
  var _loginEmail = "";
  var _loginPassword = "";
  var mycount = "Select Country";

  var countryValue;
  var stateValue;
  var cityValue;

  int date4;
  var date5;
  var date6;

  var date2;
  var date3;
  var mydob;
  int dpval = 1;
  var mygend;

  var dbval1 = 1;
  var myloc = "";
  var mygroup = "";

  var dbval = 1;

  // var dbval1 = 1;
  var dbval2 = 1;
  var dbval3 = 1;
  var dbval4 = 1;
  var dbval5 = 1;
  String mytpe;
  String mytpe1;


  // var base64Image;
  // var file;
  // var filename;

   File selectedfile;
  Response response;
  String progress;
  var prog;
  Dio dio = new Dio();


  selectFile() async {
     selectedfile = await FilePicker.getFile(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'gif'],
          //allowed extension to choose
     );
     
    //for file_pocker plugin version 2 or 2+
    /*
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'mp4'],
      //allowed extension to choose
    );

    if (result != null) {
      //if there is selected file
      selectedfile = File(result.files.single.path);
    } */
    
     setState((){}); //update the UI so that file name is shown
  }




  Future uploadFile() async {
     String uploadurl = "https://icounselgh.net/newcounse";
     //dont use http://localhost , because emulator don't get that address
     //insted use your local IP address or use live URL
     //hit "ipconfig" in windows or "ip a" in linux to get you local IP

     FormData formdata = FormData.fromMap({
          "file": await MultipartFile.fromFile(
                 selectedfile.path, 
                 filename: basename(selectedfile.path) 
                
                 //show only filename from path
           ),

           'name': _name.text,
          'email': _email.text,
          'contact': _contact.text,
          'region': myloc,
          'ctype1': mytpe,
          'ctype2': mytpe1,
          'status':"pending",
          'cgroup': mygroup,
           'gpcpin': _gpcpin.text,

      });

      response = await dio.post(uploadurl, 
          data: formdata,
          onSendProgress: (int sent, int total) {
              String percentage = (sent/total*100).toStringAsFixed(2);
              var prosent =  (sent/total*100);
              setState(() {
                  //  progress = "$sent" + " Bytes of " "$total Bytes - " +  percentage + " % uploaded";
                    progress = percentage + " % uploaded";
                   prog  = prosent;
                   //update the progress
              });
          },); 
          
      if(response.statusCode == 200){
            print(response.toString()); 
            print( response.statusMessage);
            // print(jsonDecode(response.toString()));
            //print response from server
      }else{ 
          print("Error during connection to server.");
      }

      return (response.toString());
  }

  // chooseImage() async{
    
  //     file = await ImagePicker.pickImage(source: ImageSource.gallery);
  //     base64Image = base64Encode(file.readAsBytesSync());
  //     filename = file.path.split("/").last;

  
    
  // }


  // Future Newcounsellors() async {
  //   var box = Hive.box("icousel");
  //   var userid = box.get("userid");
  //   var username = box.get("uname");
  //   var userlink = "https://icounselgh.net/newcounse.php";
  //   var response = await http.post(
  //     Uri.parse(userlink),
  //     body: {
  //       'name': _name.text,
  //       'email': _email.text,
  //       'contact': _contact.text,
  //       'region': myloc,
  //       'ctype1': mytpe,
  //       'ctype2': mytpe1,
  //       'status':"pending",
  //       'cgroup': mygroup,
  //       "image": base64Image,
  //       "pname": filename,
  //       // 'a8': _comment.text.toString(),
  //     },
  //   );
  //   var result = jsonDecode(response.body);
  //   print(result);
  //   return result;
    
  // }

  @override
  void initState() {
    mycount = "Select Country";
    mydob = "Date of Birth";
    mygend = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    var box = Hive.box("icousel");

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenheight * 0.07),
          child: AppBar(
            backgroundColor: Color(0xfffaab3b),
            centerTitle: true,
            title: Container(
              // padding:EdgeInsets.only(top: screenheight * 0.04),
              child: Text(
                "Register as a Counsellor",
                style: GoogleFonts.montserrat(),
              ),
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
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text("   Create an account",
                  //         style: TextStyle(
                  //             color: Theme.of(context).accentColor,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 20)),
                  //     Text(
                  //       "1/2   ",
                  //       style: TextStyle(fontSize: 20),
                  //     )
                  //   ],
                  // ),
                  SizedBox(height: 5),
                  CustomTextField(
                    //controller: ,
                    controller: _name,
                    hintText: "Full Name",
                    data: Icons.person,
                    isObsecure: false,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  CustomTextField(
                    //controller: ,
                    controller: _email,
                    hintText: "Email",
                    data: Icons.mail,
                    isObsecure: false,
                  ),
                  // CustomTextField(
                  //   //controller: ,
                  //   controller: _dateOfBirth,
                  //   hintText: "Date Of Birth",
                  //   data: Icons.date_range,
                  //   isObsecure: false,
                  // ),

                  SizedBox(
                    height: 2,
                  ),
                  CustomTextFieldNumber(
                    //controller: ,
                    controller: _contact,
                    hintText: "Contact",
                    data: Icons.contact_phone,
                    isObsecure: false,
                  ),

                  SizedBox(
                    height: 2,
                  ),
                  CustomTextField(
                    //controller: ,
                    controller: _gpcpin,
                    hintText: "GPC PIN",
                    data: Icons.card_membership,
                    isObsecure: false,
                  ),

                  // Row(
                  //   children: [
                  //     CustomTextFieldDiv(
                  //       //controller: ,
                  //       controller: _contact,
                  //       hintText: "Contact",
                  //       data: Icons.contact_phone,
                  //       isObsecure: false,
                  //     ),
                  //     // CustomTextFieldDiv(
                  //     //   //controller: ,
                  //     //   controller: _gender,
                  //     //   hintText: "Gender",
                  //     //   data: Icons.person,
                  //     //   isObsecure: false,
                  //     // ),
                  //     DropdownButton(
                  //       value: dpval,
                  //       items: [
                  //         DropdownMenuItem(
                  //           child: Text("Sex type"),
                  //           value: 1,
                  //         ),
                  //         DropdownMenuItem(
                  //           child: Text("Male"),
                  //           value: 2,
                  //         ),
                  //         DropdownMenuItem(
                  //           child: Text("Female"),
                  //           value: 3,
                  //         ),
                  //         DropdownMenuItem(
                  //           child: Text("Prefer not to say"),
                  //           value: 4,
                  //         ),
                  //       ],
                  //       onChanged: (int val) {
                  //         setState(() {
                  //           dpval = val;
                  //         });

                  //         if (val == 1) {
                  //           setState(() {
                  //             mygend = "Male";
                  //           });
                  //         }
                  //         else if (val == 2) {
                  //           setState(() {
                  //             mygend = "Male";
                  //           });
                  //         } else if (val == 3) {
                  //           setState(() {
                  //             mygend = "Female";
                  //           });

                  //         } else if (val == 4) {
                  //           setState(() {
                  //             mygend = "Prefer not to say";
                  //           });
                  //         }
                  //       },
                  //       hint: Text("Select Gender"),
                  //     )
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // CustomTextFieldDiv(
                      //   //controller: ,
                      //   controller: _country,
                      //   hintText: "Country",
                      //   data: Icons.flag,
                      //   isObsecure: false,
                      // ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            // primary: Colors.white70,

                            ),
                        onPressed: () {
                          showCountryPicker(
                            context: context,
                            //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                            exclude: <String>['KN', 'MF'],
                            //Optional. Shows phone code before the country name.
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              print('Select country: ${country.name}');
                              setState(() {
                                mycount = country.name;
                              });
                            },
                          );
                        },
                        child: Text(
                          mycount,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      // CustomTextFieldDiv(
                      //   //controller: ,
                      //   controller: _region,
                      //   hintText: "Region/State",
                      //   data: Icons.place,
                      //   isObsecure: false,
                      // ),

                      DropdownButton(
                        value: dbval1,
                        items: [
                          DropdownMenuItem(
                            child: Text("Select Region"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Ahafo"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("Ashanti"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("Bono"),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text("Bono East"),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text("Central"),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text("Eastern"),
                            value: 7,
                          ),
                          DropdownMenuItem(
                            child: Text("Greater Accra"),
                            value: 8,
                          ),
                          DropdownMenuItem(
                            child: Text("North East"),
                            value: 9,
                          ),
                          DropdownMenuItem(
                            child: Text("Northern"),
                            value: 10,
                          ),
                          DropdownMenuItem(
                            child: Text("Oti"),
                            value: 11,
                          ),
                          DropdownMenuItem(
                            child: Text("Savannah"),
                            value: 12,
                          ),
                          DropdownMenuItem(
                            child: Text("Upper East"),
                            value: 13,
                          ),
                          DropdownMenuItem(
                            child: Text("Upper West"),
                            value: 14,
                          ),
                          DropdownMenuItem(
                            child: Text("Volta"),
                            value: 15,
                          ),
                          DropdownMenuItem(
                            child: Text("Western"),
                            value: 16,
                          ),
                          DropdownMenuItem(
                            child: Text("Western North"),
                            value: 17,
                          ),
                          DropdownMenuItem(
                            child: Text("International"),
                            value: 18,
                          ),
                        ],
                        onChanged: (int val) {
                          setState(() {
                            dbval1 = val;
                          });

                          if (val == 1) {
                            setState(() {
                              myloc = "Select region ";
                            });
                          } else if (val == 2) {
                            setState(() {
                              myloc = "Ahafo";
                            });
                          } else if (val == 3) {
                            setState(() {
                              myloc = "Ashanti";
                            });
                          } else if (val == 4) {
                            setState(() {
                              myloc = "Bono";
                            });
                          } else if (val == 5) {
                            setState(() {
                              myloc = "Bono East";
                            });
                          } else if (val == 6) {
                            setState(() {
                              myloc = "Central";
                            });
                          } else if (val == 7) {
                            setState(() {
                              myloc = "Eastern";
                            });
                          } else if (val == 8) {
                            setState(() {
                              myloc = "Greater Accra";
                            });
                          } else if (val == 9) {
                            setState(() {
                              myloc = "North East";
                            });
                          } else if (val == 10) {
                            setState(() {
                              myloc = "Northern";
                            });
                          } else if (val == 11) {
                            setState(() {
                              myloc = "Oti";
                            });
                          } else if (val == 12) {
                            setState(() {
                              myloc = "Savannah";
                            });
                          } else if (val == 13) {
                            setState(() {
                              myloc = "Upper East";
                            });
                          } else if (val == 14) {
                            setState(() {
                              myloc = "Upper West";
                            });
                          } else if (val == 15) {
                            setState(() {
                              myloc = "Volta";
                            });
                          } else if (val == 16) {
                            setState(() {
                              myloc = "Western";
                            });
                          } else if (val == 17) {
                            setState(() {
                              myloc = "Western North";
                            });
                          } else if (val == 18) {
                            setState(() {
                              myloc = "International";
                            });
                          }
                        },
                        hint: Text("Select  location "),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // CustomTextFieldDiv(
                      //   //controller: ,
                      //   controller: _country,
                      //   hintText: "Country",
                      //   data: Icons.flag,
                      //   isObsecure: false,
                      // ),

                      DropdownButton(
                        value: dpval,
                        items: [
                          DropdownMenuItem(
                            child: Text(" Sex type"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Male"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("Female"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("Prefer not to say"),
                            value: 4,
                          ),
                        ],
                        onChanged: (int val) {
                          setState(() {
                            dpval = val;
                          });

                          if (val == 1) {
                            setState(() {
                              mygend = "Male";
                            });
                          } else if (val == 2) {
                            setState(() {
                              mygend = "Male";
                            });
                          } else if (val == 3) {
                            setState(() {
                              mygend = "Female";
                            });
                          } else if (val == 4) {
                            setState(() {
                              mygend = "Prefer not to say";
                            });
                          }
                        },
                        hint: Text("Select Gender"),
                      ),

                      // CustomTextFieldDiv(
                      //   //controller: ,
                      //   controller: _region,
                      //   hintText: "Region/State",
                      //   data: Icons.place,
                      //   isObsecure: false,
                      // ),

                      DropdownButton(
                        value: dbval2,
                        items: [
                          DropdownMenuItem(
                            child: Text("Select Target Group "),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Child and Adolescent"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("Religious"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("School"),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text("Adult and Aged"),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text("Corporate"),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text("Community"),
                            value: 7,
                          ),
                        ],
                        onChanged: (int val) {
                          setState(() {
                            dbval2 = val;
                          });

                          if (val == 1) {
                            setState(() {
                              mygroup = "Select group ";
                            });
                          } else if (val == 2) {
                            setState(() {
                              mygroup = "Child and Adolescent";
                            });
                          } else if (val == 3) {
                            setState(() {
                              mygroup = "Religious";
                            });
                          } else if (val == 4) {
                            setState(() {
                              mygroup = "School";
                            });
                          } else if (val == 5) {
                            setState(() {
                              mygroup = "Adult and Aged";
                            });
                          } else if (val == 6) {
                            setState(() {
                              mygroup = "Corporate";
                            });
                          } else if (val == 7) {
                            setState(() {
                              mygroup = "Community";
                            });
                          }
                        },
                        hint: Text("Select  Group "),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    width: double.infinity,
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
                        value: dbval,
                        items: [
                          DropdownMenuItem(
                            child: Text("Select Counsellor type"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Academic and Career"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("Relationship and Marriage"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("Regenerative Health"),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text("Behaviour Modifications"),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text("Crisis and Bereavement"),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text("Addiction"),
                            value: 7,
                          ),
                          DropdownMenuItem(
                            child: Text("Financial"),
                            value: 8,
                          ),
                          DropdownMenuItem(
                            child: Text("Reproductive Health"),
                            value: 9,
                          ),
                          DropdownMenuItem(
                            child: Text("Sexuality Crisis"),
                            value: 10,
                          ),
                        ],
                        onChanged: (int val) {
                          setState(() {
                            dbval = val;
                          });
                          if (val == 1) {
                            setState(() {
                              mytpe = "";
                            });
                          } else if (val == 2) {
                            setState(() {
                              mytpe = "Academic and Career";
                            });
                          } else if (val == 3) {
                            setState(() {
                              mytpe = "Relationship and Marriage";
                            });
                          } else if (val == 4) {
                            setState(() {
                              mytpe = "Regenerative Health";
                            });
                          } else if (val == 5) {
                            setState(() {
                              mytpe = "Behaviour Modifications";
                            });
                          } else if (val == 6) {
                            setState(() {
                              mytpe = "Crisis and Bereavement";
                            });
                          } else if (val == 7) {
                            setState(() {
                              mytpe = "Addiction";
                            });
                          } else if (val == 8) {
                            setState(() {
                              mytpe = "Financial";
                            });
                          } else if (val == 9) {
                            setState(() {
                              mytpe = "Reproductive Health";
                            });
                          } else if (val == 10) {
                            setState(() {
                              mytpe = "Sexuality Crisisa";
                            });
                          }
                        },
                        hint: Text("Select Counselling need "),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    width: double.infinity,
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
                          child: Text(" Select  Another type (if any)"),
                          value: 1,
                        ),
                        
                        DropdownMenuItem(
                          child: Text("Academic and Career"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("Relationship and Marriage"),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text("Regenerative Health"),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          child: Text("Behaviour Modifications"),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text("Crisis and Bereavement"),
                          value: 6,
                        ),
                        DropdownMenuItem(
                          child: Text("Addiction"),
                          value: 7,
                        ),
                        DropdownMenuItem(
                          child: Text("Financial"),
                          value: 8,
                        ),
                        DropdownMenuItem(
                          child: Text("Reproductive Health"),
                          value: 9,
                        ),
                        DropdownMenuItem(
                          child: Text("Sexuality Crisis"),
                          value: 10,
                        ),
                      ],
                      onChanged: (int val) {
                        setState(() {
                          dbval5 = val;
                        });
                        if (val == 1) {
                          setState(() {
                            mytpe1 = "";
                          });
                        }
                        else if (val == 2) {
                          setState(() {
                            mytpe1 = "Academic and Career";
                          });
                        } else if (val == 3) {
                          setState(() {
                            mytpe1 = "Relationship and Marriage";
                          });
                        } else if (val == 4) {
                          setState(() {
                            mytpe1 = "Regenerative Health";
                          });
                        } else if (val == 5) {
                          setState(() {
                            mytpe1 = "Behaviour Modifications";
                          });
                        } else if (val == 6) {
                          setState(() {
                            mytpe1 = "Crisis and Bereavement";
                          });
                        } else if (val == 7) {
                          setState(() {
                            mytpe1 = "Addiction";
                          });
                        } else if (val == 8) {
                          setState(() {
                            mytpe1 = "Financial";
                          });
                        } else if (val == 9) {
                          setState(() {
                            mytpe1 = "Reproductive Health";
                          });
                        } else if (val == 10) {
                          setState(() {
                            mytpe1 = "Sexuality Crisisa";
                          });
                        }
                      },
                      hint: Text("Select Counselling need "),
                ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: OutlineButton(
                onPressed: (){
                           selectFile();
                         },
                child: selectedfile == null?
                              Text("Add Your profile picture"):
                              Text(basename(selectedfile.path)),
              ),
                  ),

                  SizedBox(height:10),
                  // Container( 
                  //       margin: EdgeInsets.all(10),
                  //       //show file name here
                  //       child:progress == null?
                  //             Text("Progress: 0%"):
                  //             Text(basename("Progress: $progress"), 
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(fontSize: 18),),
                  //       //show progress status here
                  //   ),

                  // SizedBox(height: 10),
                  GestureDetector(
                    onTap: ()async {

                      if (_name.text == "") {
                          SweetAlert.show(
                          context,
                          title: "sorry",
                          subtitle: "Please enter your name",
                          style: SweetAlertStyle.error,
                        );
                      } 


                      else if (_email.text == "") {
                          SweetAlert.show(
                          context,
                          title: "sorry",
                          subtitle: "please enter your valid email address",
                          style: SweetAlertStyle.error,
                        );
                      }   
                      else{
                                      SweetAlert.show(
                              context,
                              title: "Loading ..",
                              subtitle: "Please wait...",
                              style: SweetAlertStyle.loading,
                            );

                            var repo = await uploadFile();

                            if (repo == "pending") {
                              SweetAlert.show(
                                context,
                                title: "Oops",
                                subtitle: "Your already have pending request",
                                style: SweetAlertStyle.error,
                              );
                            } 
                            
                            else if (repo == "Already acounsellor") {
                              SweetAlert.show(
                                context,
                                title: "Oops",
                                subtitle: "You are already a on the paltfom",
                                style: SweetAlertStyle.error,
                              );
                            } 
                            else if (repo == "upload complete") {
                              creatNotificationnopic('Your request to join iCounsel-Gh Counsellors is submitted for review ');
                              SweetAlert.show(
                                context,
                                title: "Congrats!",
                                subtitle: "Your request is submitted for review .",
                                style: SweetAlertStyle.success,
                              );
                              // print(resp);

                              Future.delayed(Duration(seconds: 4), () {
                                // Navigator.of(context).pop();
                                Route route = MaterialPageRoute(builder: (c) => HomeScreen());
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


                            else if (repo == "Erro saving") {
                              SweetAlert.show(
                                context,
                                title: "Warning",
                                subtitle: "Failed to upload image",
                                style: SweetAlertStyle.error,
                              );
                            }

                            else if (repo == "No file is sublitted.") {
                              SweetAlert.show(
                                context,
                                title: "Warning",
                                subtitle: "Please select  valide image file",
                                style: SweetAlertStyle.error,
                              );
                            }
                      }
                    // var repo = await  uploadFile();
                   
                    },
                    child: Container(
                        //padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(10),
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
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

class CustomTextFieldDiv extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;

  CustomTextFieldDiv(
      {Key key, this.controller, this.data, this.hintText, this.isObsecure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Container(
      height: 50,
      width: screenwidth / 2 - 20,
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

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  final bool isObsecure;

  CustomPasswordTextField(
      {Key key, this.controller, this.data, this.hintText, this.isObsecure})
      : super(key: key);

  @override
  _CustomPasswordTextFieldState createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isVisible = true;

  void _visible() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

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
        controller: widget.controller,
        obscureText: _isVisible,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            //border: InputBorder.none,
            focusColor: Theme.of(context).primaryColor,
            hintText: widget.hintText ?? "input",
            suffixIcon: IconButton(
                icon: _isVisible
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    print(_isVisible);

                    _visible();
                    print("done");
                    print(_isVisible);
                  });
                }),
            prefixIcon:
                Icon(widget.data, color: Theme.of(context).primaryColor)),
      ),
    );
  }
}
class CustomTextFieldNumber extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;

  CustomTextFieldNumber(
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
        keyboardType: TextInputType.number,
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