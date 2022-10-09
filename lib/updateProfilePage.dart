import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:icounselgh/profilepage.dart';
import 'package:sweetalert/sweetalert.dart';
import 'dart:convert';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController _email = TextEditingController();

  TextEditingController _name = TextEditingController();
  TextEditingController _gender = TextEditingController();

  TextEditingController _dateOfBirth = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _region = TextEditingController();

  TextEditingController _password = TextEditingController();
  String _loginEmail = "";
  String _loginPassword = "";

  Future updateprofile() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    String url = "https://icounselgh.net/updateprofile";
    final response = await http.post(Uri.parse(url), body: {
      'userid': userid,
      'name': _name.text,
      'email': _email.text,
      'dob': _dateOfBirth.text,
      'gender': _gender.text,
      'contact': _contact.text,
      'country': _country.text,
      'region': _region.text,
      // 'password': _password.text,
    });
    var result = jsonDecode(response.body);
    return result;
  }

  var uname;
  var umail;
  var ucontact;
  var ucountry;
  var ugender;
  var ustate;
  var udob;
  var box = Hive.box("icousel");
  @override
  void initState() {
    uname = box.get("uname");
    umail = box.get("umail");
    ucontact = box.get("ucontact");
    ucountry = box.get("ucountry");
    ugender = box.get("ugender");
    ustate = box.get("ustate");
    udob = box.get("udob");
    _email.text = umail;
    _name.text = uname;
    _contact.text = ucontact;
    _dateOfBirth.text = udob;
    _gender.text = ugender;
    _country.text = ucountry;
    _region.text = ustate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            title: Text("update profile"), backgroundColor: Colors.white),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                CustomTextField(
                  //controller: ,
                  controller: _name,
                  hintText: uname,

                  data: Icons.person,
                  isObsecure: false,
                ),
                SizedBox(
                  height: 3,
                ),
                CustomTextField(
                  //controller: ,
                  controller: _email,
                  hintText: umail,
                  data: Icons.mail,
                  isObsecure: false,
                ),
                CustomTextField(
                  //controller: ,
                  controller: _dateOfBirth,
                  hintText: udob,
                  data: Icons.date_range,
                  isObsecure: false,
                ),
                Row(
                  children: [
                    CustomTextFieldDiv(
                      //controller: ,
                      controller: _contact,
                      hintText: ucontact,
                      data: Icons.contact_phone,
                      isObsecure: false,
                    ),
                    CustomTextFieldDiv(
                      //controller: ,
                      controller: _gender,
                      hintText: ugender,
                      data: Icons.person,
                      isObsecure: false,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomTextFieldDiv(
                      //controller: ,
                      controller: _country,
                      hintText: ucountry,
                      data: Icons.flag,
                      isObsecure: false,
                    ),
                    CustomTextFieldDiv(
                      //controller: ,
                      controller: _region,
                      hintText: ustate,
                      data: Icons.place,
                      isObsecure: false,
                    ),
                  ],
                ),
                SizedBox(height: 100),
                GestureDetector(
                  onTap: () async {
                    SweetAlert.show(
                      context,
                      title: "loading..",
                      subtitle: "please wait...",
                      showCancelButton: false,
                      style: SweetAlertStyle.loading,
                    );
                    if (_email.text == "" &&
                        _name.text == "" &&
                        _dateOfBirth.text == "" &&
                        _contact.text == "" &&
                        _gender.text == "" &&
                        _country.text == "" &&
                        _region.text == "") {
                      Navigator.of(context).pop();
                      SweetAlert.show(context,
                          title: "oops!",
                          subtitle: "all field can't be empty",
                          style: SweetAlertStyle.error,
                          showCancelButton: false);
                    } 
                    //else if (_email.text == "" ||
                    //     _name.text == "" ||
                    //     _dateOfBirth.text == "" ||
                    //     _contact.text == "" ||
                    //     _gender.text == "" ||
                    //     _country.text == "" ||
                    //     _region.text == "") {
                    //   setState(() {
                    //     _email.text = umail;
                    //     _name.text = uname;
                    //     _contact.text = ucontact;
                    //     _dateOfBirth.text = udob;
                    //     _gender.text = ugender;
                    //     _country.text = ucountry;
                    //     _region.text = ustate;
                    //   });

                      
                    // }

                    // else if (_email.text != "" && _name.text == "" && _dateOfBirth.text != "" && _contact.text != "" && _gender.text != "" && _country.text != "" &&  _region.text !="") {
                    //     setState(() {
                    //       _name.text = uname;

                    //     });
                    // }
                    // else if (_email.text != "" && _name.text != "" && _dateOfBirth.text == "" && _contact.text != "" && _gender.text != "" && _country.text != "" &&  _region.text !="") {
                    //     setState(() {
                    //       _dateOfBirth.text = udob;

                    //     });
                    // }

                    // else if (_email.text != "" && _name.text != "" && _dateOfBirth.text != "" && _contact.text == "" && _gender.text != "" && _country.text != "" &&  _region.text !="") {
                    //     setState(() {
                    //       _contact.text = ucontact;

                    //     });
                    // }

                    // else if (_email.text != "" && _name.text != "" && _dateOfBirth.text != "" && _contact.text != "" && _gender.text == "" && _country.text != "" &&  _region.text !="") {
                    //     setState(() {
                    //       _gender.text = ugender;

                    //     });
                    // }

                    // else if (_email.text != "" && _name.text != "" && _dateOfBirth.text != "" && _contact.text != "" && _gender.text != "" && _country.text == "" &&  _region.text !="") {
                    //     setState(() {
                    //       _country.text = ucountry;

                    //     });
                    // }
                    // else if (_email.text != "" && _name.text != "" && _dateOfBirth.text != "" && _contact.text != "" && _gender.text != "" && _country.text != "" &&  _region.text =="") {
                    //     setState(() {
                    //       _region.text = ustate;

                    //     });
                    // }

                    //  else if (_email.text == "" && _name.text == "" && _dateOfBirth.text != "" && _contact.text != "" && _gender.text != "" && _country.text != "" &&  _region.text !="") {
                    //     setState(() {
                    //       _email.text = umail;
                    //        _name.text = uname;

                    //     });
                    // }

                    // else if (_email.text == "" && _name.text != "" && _dateOfBirth.text == "" && _contact.text != "" && _gender.text != "" && _country.text != "" &&  _region.text !="") {
                    //     setState(() {
                    //       _email.text = umail;
                    //        _dateOfBirth.text = udob;

                    //     });
                    // }

                    // else if (_email.text == "" && _name.text != "" && _dateOfBirth.text != "" && _contact.text == "" && _gender.text != "" && _country.text != "" &&  _region.text !="") {
                    //     setState(() {
                    //       _email.text = umail;
                    //        _contact.text = ucontact;

                    //     });
                    // }

                    // else if (_email.text == "" && _name.text != "" && _dateOfBirth.text != "" && _contact.text != "" && _gender.text == "" && _country.text != "" &&  _region.text !="") {
                    //     setState(() {
                    //       _email.text = umail;
                    //        _gender.text = ugender;

                    //     });
                    // }

                    // else if (_email.text == "" && _name.text != "" && _dateOfBirth.text != "" && _contact.text != "" && _gender.text != "" && _country.text == "" &&  _region.text !="") {
                    //     setState(() {
                    //       _email.text = umail;
                    //        _country.text = ucountry;

                    //     });
                    // }

                    // else if (_email.text == "" && _name.text != "" && _dateOfBirth.text != "" && _contact.text != "" && _gender.text != "" && _country.text != "" &&  _region.text =="") {
                    //     setState(() {
                    //       _email.text = umail;
                    //        _region.text = ustate;

                    //     });
                    // }
                    else {
                      var resp;
                      try {
                        resp = await updateprofile();
                        print(resp);
                      } catch (e) {
                        return;
                      }

                      SweetAlert.show(
                        context,
                        title: "loading..",
                        subtitle: "please wait...",
                        showCancelButton: false,
                        style: SweetAlertStyle.loading,
                      );

                      if (resp == "failed") {
                        // Navigator.of(context).pop();
                        SweetAlert.show(context,
                            title: "Sorry",
                            subtitle: "something went wrong",
                            showCancelButton: false,
                            style: SweetAlertStyle.error);
                      } else if (resp == "invalid") {
                        // Navigator.of(context).pop();
                        SweetAlert.show(context,
                            title: "Sorry",
                            subtitle: "This account does not exist ",
                            showCancelButton: false,
                            style: SweetAlertStyle.error);
                      } else if (resp == "updated") {
                        // var repo = await user();

                        box.put('uname', _name.text);
                        box.put('umail', _email.text);
                        box.put('ucontact', _contact.text);
                        box.put('ucountry', _country.text);
                        box.put('ugender', _gender.text);
                        box.put('ustate', _region.text);
                        box.put('udob', _dateOfBirth.text);

                        // box.put("userid", value)
                        // Navigator.of(context).pop();
                        SweetAlert.show(
                          context,
                          title: "Update successful",
                          // subtitle: "Sweet alert is pretty",
                          style: SweetAlertStyle.success,
                          showCancelButton:
                              false, // There won't be any cancel button
                          // buttons: false;// There won't be any confirm button
                        );

                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.of(context).pop();
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Myprofile()),
                          //   (Route<dynamic> route) => false,
                          // );
                        });
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
                          "Update",
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
