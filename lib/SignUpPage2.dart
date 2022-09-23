import 'package:flutter/material.dart';
import 'package:icounselgh/notifications.dart';

import 'loginPage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';
import 'HomePage.dart';

import 'dart:convert';

class SignUpPage2 extends StatefulWidget {
  @override
  _SignUpPage2State createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  TextEditingController _repeatPassword = TextEditingController();
  TextEditingController _password = TextEditingController();
  String _loginEmail = "";
  String _loginPassword = "";

  var box = Hive.box("icousel");
  var pass;
  var repass;
  var uid;

  Future register() async {
    String regurl = "https://icounselgh.net/reg";

    var uname = box.get("uname");
    var uemail = box.get("uemail");
    var udob = box.get("udob");
    var ucontact = box.get("ucontact");
    var ugender = box.get("ugender");
    var ucountry = box.get("ucountry");
    var ustate = box.get("ustate");
    var response = await http.post(Uri.parse(regurl), body: {
      'name': uname,
      'email': uemail,
      'dob': udob,
      'contact': ucontact,
      'gender': ugender,
      'country': ucountry,
      'state': ustate,
      'passcode': _password.text,
    });
    var result = jsonDecode(response.body);
    return result;
  }


  Future mylogin() async {

     var uname = box.get("uname");
    var uemail = box.get("uemail");
    var udob = box.get("udob");
    var ucontact = box.get("ucontact");
    var ugender = box.get("ugender");
    var ucountry = box.get("ucountry");
    var ustate = box.get("ustate");
    String url = "https://icounselgh.net/app-login";
    final response = await http.post(Uri.parse(url), body: {
      'username': uemail,
      'password': _password.text,
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
  var upass;

  var mymess;

  @override
  Widget build(BuildContext context) {
    // double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("   Create an account",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                Text(
                  "2/2   ",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            SizedBox(height: 30),
            CustomPasswordTextField(
              //controller: ,
              controller: _password,
              hintText: "password",
              data: Icons.lock,
              isObsecure: true,
            ),
            CustomPasswordTextField(
              //controller: ,
              controller: _repeatPassword,
              hintText: "Repeat password",
              data: Icons.lock,
              isObsecure: true,
            ),
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
            SizedBox(height: 120),
            GestureDetector(
              onTap: () async {
                if (_password.text != _repeatPassword.text) {
                  SweetAlert.show(
                    context,
                    title: "Warning",
                    subtitle: "Password do not match",
                    style: SweetAlertStyle.error,
                  );
                } 
                  // else if(_password.text.length){

                  // }
                else {
                  var resp = await register();
                  if (resp == "alreaderexist") {
                    SweetAlert.show(
                      context,
                      title: "Warning",
                      subtitle: "User already Exist",
                      style: SweetAlertStyle.error,
                    );
                    print(resp);
                  } else if (resp == "allfieldrequried") {
                    SweetAlert.show(
                      context,
                      title: "warning",
                      subtitle: 'all fields must be filed',
                      style: SweetAlertStyle.error,
                    );
                    print(resp);
                  } else if (resp == "registered") {
                      creatNotificationnopic('Welcome to the TUCEE iCounsel-Gh App. We are excited to have you on board!.');
                      var rep;
                      try {
                      rep = await mylogin();
                      print(rep);
                        
                      } catch(e) {
                        return ;
                      }

                      print(rep[0]["name"]);
                    setState(() {
                      uid = rep[0]['id'];
                      mymess = "login successful";
                    });
                    print(uid);
                    var box = Hive.box("icousel");
                    box.put("islog", 1);
                    box.put('userid', uid);
                    // var repo = await user();
                    setState(() {
                      uname = rep[0]["name"];
                      umail = rep[0]["email"];
                      ucontact = rep[0]["contact"];
                      ucountry = rep[0]["country"];
                      ugender = rep[0]["gender"];
                      ustate = rep[0]["state"];
                      udob = rep[0]["dob"];
                      upass = rep[0]["passcode"];
                    });

                    box.put('uname', uname);
                    box.put('umail', umail);
                    box.put('ucontact', ucontact);
                    box.put('ucountry', ucountry);
                    box.put('ugender', ugender);
                    box.put('ustate', ustate);
                    box.put('udob', udob);
                    box.put('upass', upass);
                    SweetAlert.show(
                      context,
                      title: "Congrats!",
                      subtitle:
                          "Your Account is created successfully.",
                      style: SweetAlertStyle.success,
                    );
                    print(resp);

                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pop();
                      Route route =
                          MaterialPageRoute(builder: (c) => HomeScreen());
                      Navigator.pushReplacement(context, route);
                    });
                   
                  } else if (resp == "failed") {
                    SweetAlert.show(
                      context,
                      title: "Warning",
                      subtitle: 'Faild to create account. try again',
                      style: SweetAlertStyle.error,
                    );
                    print(resp);
                  } else {
                    SweetAlert.show(context, 
                    title: "Sorry!",
                    subtitle: "Something Went wrong .try again",
                    style: SweetAlertStyle.error
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
                      "Sign Up",
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
