import 'package:flutter/material.dart';
import 'package:icounselgh/resetpass.dart';
import 'HomePage.dart';
import 'signUpPage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// late AnimationController controller;
// AnimationController controller;

  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();
  String _loginEmail = "";
  String _loginPassword = "";
  var uid;

  Future mylogin() async {
    String url = "https://icounselgh.net/app-login";
    final response = await http.post(Uri.parse(url), body: {
      'username': _email.text,
      'password': _password.text,
    });
    var result = jsonDecode(response.body);
    return result;
  }

  Future user() async {
    var box = Hive.box("icousel");
    var userid = box.get("userid");
    var userlink = "https://icounselgh.net/user";
    var response = await http.post(
      Uri.parse(userlink),
      body: {'userid': userid},
    );
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Please wait"),
                // Image.asset('assets/images/infinity.gif'),
                Image(image: AssetImage("assets/images/Pulse.gif")),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    mymess = " Please wait ....";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 1),
            // Text("   Login",
            //     style: TextStyle(
            //         color: Theme.of(context).accentColor,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20)),
            Image(
              image: AssetImage("assets/images/logo.png"),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.31,
            ),
            SizedBox(height: 10),
            CustomTextField(
              //controller: ,
              controller: _email,
              hintText: "Email / phone number ",
              data: Icons.person,
              isObsecure: false,
            ),
            SizedBox(
              height: 10,
            ),
            CustomPasswordTextField(
              isObsecure: true,
              data: Icons.lock,
              hintText: "Password",
              controller: _password,
            ),

            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text("Do you have an account? "),
                  GestureDetector(
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (c) => Resetpass());
                      Navigator.push(context, route);
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 70),
            GestureDetector(
              onTap: () async {
                // _showMyDialog();
                SweetAlert.show(
                  context,
                  title: "loading..",
                  subtitle: "please wait...",
                  showCancelButton: false,
                  style: SweetAlertStyle.loading,
                );
                if (_email.text == "") {
                  Navigator.of(context).pop();
                  SweetAlert.show(context,
                      title: "Warning!",
                      subtitle: "please enter email",
                      style: SweetAlertStyle.error,
                      showCancelButton: false);
                } else if (_password.text == "") {
                  Navigator.of(context).pop();
                  SweetAlert.show(context,
                      title: 'Warning!',
                      subtitle: "password can not be empty",
                      showCancelButton: false,
                      style: SweetAlertStyle.error);
                } else {
                  var resp;
                  try {
                    resp = await mylogin();
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
                        subtitle: "Invalid login credentials",
                        showCancelButton: false,
                        style: SweetAlertStyle.error);
                  } else {
                    // print(resp);
                    // print(resp[0]["name"]);
                    setState(() {
                      uid = resp[0]['id'];
                      mymess = "login successful";
                    });
                    // print(uid);
                    var box = Hive.box("icousel");
                    box.put("islog", 1);
                    box.put('userid', uid);
                    // var repo = await user();
                    setState(() {
                      uname = resp[0]["name"];
                      umail = resp[0]["email"];
                      ucontact = resp[0]["contact"];
                      ucountry = resp[0]["country"];
                      ugender = resp[0]["gender"];
                      ustate = resp[0]["state"];
                      udob = resp[0]["dob"];
                      upass = resp[0]["passcode"];
                    });

                    box.put('uname', uname);
                    box.put('umail', umail);
                    box.put('ucontact', ucontact);
                    box.put('ucountry', ucountry);
                    box.put('ugender', ugender);
                    box.put('ustate', ustate);
                    box.put('udob', udob);
                    box.put('upass', upass);

                    // box.put("userid", value)
                    // Navigator.of(context).pop();
                    SweetAlert.show(
                      context,
                      title: "Login successful",
                      // subtitle: "Sweet alert is pretty",
                      style: SweetAlertStyle.success,
                      showCancelButton:
                          false, // There won't be any cancel button
                      // buttons: false;// There won't be any confirm button
                    );

                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.of(context).pop();
                      Route route =
                          MaterialPageRoute(builder: (c) => HomeScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  }
                }
                // SweetAlert.show(context,
                //       title: "please wait",
                //       // subtitle: "Sweet alert is pretty",
                //       // style: SweetAlertStyle.,
                //       showCancelButton: false,

                //       );

                // Route route = MaterialPageRoute(builder: (c) => HomeScreen());
                // Navigator.push(context, route);
              },
              child: Container(
                  //padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't  have an account? "),
                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => SignUpPage());
                    Navigator.push(context, route);
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                )
              ],
            ),
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

class CustomSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final IconData data;
  final String hintText;
  bool isObsecure = true;

  CustomSearchTextField(
      {Key key,
      this.controller,
      this.data,
      this.hintText,
      this.isObsecure,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.only(bottom: 10, left: 30, right: 30),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        obscureText: isObsecure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusColor: Theme.of(context).primaryColor,
            hintText: hintText ?? "input",
            prefixIcon: Icon(data, color: Colors.grey[500])),
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