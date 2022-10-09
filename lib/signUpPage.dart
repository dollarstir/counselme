import 'package:flutter/material.dart';

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

import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _gender = TextEditingController();

  TextEditingController _dateOfBirth = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _region = TextEditingController();

  TextEditingController _password = TextEditingController();
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
    var box = Hive.box("icousel");

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("   Create an account",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                Text(
                  "1/2   ",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            SizedBox(height: 30),
            CustomTextField(
              //controller: ,
              controller: _name,
              hintText: "Full Name",
              data: Icons.person,
              isObsecure: false,
            ),
            SizedBox(
              height: 3,
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
              CustomTextFieldNumber(
              //controller: ,
              controller: _contact,
              hintText: "Contact",
              data: Icons.contact_phone,
              isObsecure: false,
            ),
            

            SizedBox(
              height: 3,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 18, right: 18),
              child: FlatButton(
                  // padding: EdgeInsets.only(le),

                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(DateTime.now().year - 100, 12, 20,
                            DateTime.now().month, DateTime.now().day),
                        maxTime: DateTime(DateTime.now().year + 20, 12, 20),
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
                        mydob = date2;
                        // dateSeleted = true;
                      });
                      //Text("You have scheduled a meeting on $date");
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    mydob,
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(height: 10),

            Container(
              // color: Colors.orange,
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Card(
                elevation:2,
                // color: Colors.orange,
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  padding: EdgeInsets.only(left: 10),
                  child: DropdownButton(
                    value: dpval,
                    // focusColor: Colors.white,
                    // dropdownColor: Colors.white,
                    // iconEnabledColor: Colors.white,
                    // iconDisabledColor: Colors.white,
                    isExpanded: true,
                    items: [
                      
                      DropdownMenuItem(
                        child: Text("Sex type"),
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
                ),
              ),
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

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 15, top: 10, right: 15),
              child: ElevatedButton(
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
            ),

            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Card(
                elevation: 2,
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  padding: EdgeInsets.only(left: 10),
                  child: DropdownButton(
                    value: dbval1,
                    isExpanded: true,
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
                      }
                    },
                    hint: Text("Select  location "),
                  ),
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     // CustomTextFieldDiv(
            //     //   //controller: ,
            //     //   controller: _country,
            //     //   hintText: "Country",
            //     //   data: Icons.flag,
            //     //   isObsecure: false,
            //     // ),

            //     ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //           // primary: Colors.white70,

            //           ),
            //       onPressed: () {
            //         showCountryPicker(
            //           context: context,
            //           //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
            //           exclude: <String>['KN', 'MF'],
            //           //Optional. Shows phone code before the country name.
            //           showPhoneCode: true,
            //           onSelect: (Country country) {
            //             print('Select country: ${country.name}');
            //             setState(() {
            //               mycount = country.name;
            //             });
            //           },
            //         );
            //       },
            //       child: Text(
            //         mycount,
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),

            //     // CustomTextFieldDiv(
            //     //   //controller: ,
            //     //   controller: _region,
            //     //   hintText: "Region/State",
            //     //   data: Icons.place,
            //     //   isObsecure: false,
            //     // ),

            //     DropdownButton(
            //       value: dbval1,
            //       items: [

            //          DropdownMenuItem(
            //           child: Text("Select Region"),
            //           value: 1,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Ahafo"),
            //           value: 2,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Ashanti"),
            //           value: 3,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Bono"),
            //           value: 4,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Bono East"),
            //           value: 5,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Central"),
            //           value: 6,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Eastern"),
            //           value: 7,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Greater Accra"),
            //           value: 8,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("North East"),
            //           value: 9,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Northern"),
            //           value: 10,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Oti"),
            //           value: 11,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Savannah"),
            //           value: 12,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Upper East"),
            //           value: 13,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Upper West"),
            //           value: 14,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Volta"),
            //           value: 15,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Western"),
            //           value: 16,
            //         ),
            //         DropdownMenuItem(
            //           child: Text("Western North"),
            //           value: 17,
            //         ),
            //       ],
            //       onChanged: (int val) {
            //         setState(() {
            //           dbval1 = val;
            //         });

            //         if (val == 1) {
            //           setState(() {
            //             myloc = "Select region ";
            //           });
            //         }
            //         else if (val == 2) {
            //           setState(() {
            //             myloc = "Ahafo";
            //           });
            //         } else if (val == 3) {
            //           setState(() {
            //             myloc = "Ashanti";
            //           });
            //         } else if (val == 4) {
            //           setState(() {
            //             myloc = "Bono";
            //           });
            //         } else if (val == 5) {
            //           setState(() {
            //             myloc = "Bono East";
            //           });
            //         } else if (val == 6) {
            //           setState(() {
            //             myloc = "Central";
            //           });
            //         } else if (val == 7) {
            //           setState(() {
            //             myloc = "Eastern";
            //           });
            //         } else if (val == 8) {
            //           setState(() {
            //             myloc = "Greater Accra";
            //           });
            //         } else if (val == 9) {
            //           setState(() {
            //             myloc = "North East";
            //           });
            //         } else if (val == 10) {
            //           setState(() {
            //             myloc = "Northern";
            //           });
            //         } else if (val == 11) {
            //           setState(() {
            //             myloc = "Oti";
            //           });
            //         } else if (val == 12) {
            //           setState(() {
            //             myloc = "Savannah";
            //           });
            //         } else if (val == 13) {
            //           setState(() {
            //             myloc = "Upper East";
            //           });
            //         } else if (val == 14) {
            //           setState(() {
            //             myloc = "Upper West";
            //           });
            //         } else if (val == 15) {
            //           setState(() {
            //             myloc = "Volta";
            //           });
            //         } else if (val == 16) {
            //           setState(() {
            //             myloc = "Western";
            //           });
            //         } else if (val == 17) {
            //           setState(() {
            //             myloc = "Western North";
            //           });
            //         }
            //       },
            //       hint: Text("Select  location "),
            //     ),
            //   ],
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                GestureDetector(
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (c) => LoginPage());
                      Navigator.push(context, route);
                    },
                    child: Text("Login",
                        style: TextStyle(color: Theme.of(context).accentColor)))
              ],
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                if (_name.text == "" ||
                    _email.text == "" ||
                    mydob == "Date of Birth" ||
                    _contact.text == "" ||
                    mygend == "" ||
                    mycount == "Select Country" ||
                    myloc == "") {
                  SweetAlert.show(context,
                      title: "Warning",
                      subtitle: "All field must be field",
                      style: SweetAlertStyle.error,
                      showCancelButton: false);
                } else {
                  var uname = box.put("uname", _name.text);
                  var uemail = box.put("uemail", _email.text);
                  var udob = box.put("udob", mydob);
                  var ucontact = box.put("ucontact", _contact.text);
                  var ugender = box.put("ugender", mygend);
                  var ucountry = box.put("ucountry", mycount);
                  var ustate = box.put("ustate", myloc);

                  Route route =
                      MaterialPageRoute(builder: (c) => SignUpPage2());
                  Navigator.push(context, route);
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
          ],
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
