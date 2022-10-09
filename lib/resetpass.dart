import 'package:flutter/material.dart';
import 'package:icounselgh/newpass.dart';
import 'HomePage.dart';
import 'signUpPage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';
import 'dart:math';

import 'dart:convert';

class Resetpass extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Resetpass> {
// late AnimationController controller;
// AnimationController controller;
  var is_visible1 = false;
  var is_visible = false;
    var is_visible2 = true;
    var is_visible3 = true;

  String otp = Random().nextInt(999999).toString().padLeft(6, '0');

  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();

  TextEditingController _password = TextEditingController();
  String _loginEmail = "";
  String _loginPassword = "";
  var uid;

  Future sendotp() async {
    String url = "https://icounselgh.net/otp";
    final response = await http.post(Uri.parse(url), body: {
      'number': _phone.text,
      'password': otp,
    });
    var result = jsonDecode(response.body);
    // print(result);
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
            SizedBox(height: 10),
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
            SizedBox(height: 70),
            Visibility(
              visible:is_visible3,
              child: CustomTextField(
                //controller: ,
                controller: _phone,
                hintText: " Enter phone number",
                data: Icons.phone,
                isObsecure: false,
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: is_visible2,
              child: GestureDetector(

                onTap: () async {
                 setState(() {
                    is_visible = false ;
                  is_visible1 = false;
                   is_visible3 = true;

                 });
                  // _showMyDialog();
                  SweetAlert.show(
                    context,
                    title: "loading..",
                    subtitle: "please wait...",
                    showCancelButton: false,
                    style: SweetAlertStyle.loading,
                  );
                  if (_phone.text == "") {
                    Navigator.of(context).pop();
                    SweetAlert.show(context,
                        title: "Warning!",
                        subtitle: "please enter valid phone number",
                        style: SweetAlertStyle.error,
                        showCancelButton: false);
                  }else {
                    var resp;
                    try {
                      resp = await sendotp();
                      print(resp);
                    } catch (e) {
                      return;
                    }

                   

                    if (resp == "failed") {
                      // Navigator.of(context).pop();
                      SweetAlert.show(context,
                          title: "Sorry",
                          subtitle: "the number entered is not on any account",
                          showCancelButton: false,
                          style: SweetAlertStyle.error);
                    } else if(resp == 'sent') {
                      // print(resp);
                      // print(resp[0]["name"]);
                      setState(() {
                        // uid = resp[0]['id'];
                        mymess = "verification code sent";
                        
                      });
                     
                      var box = Hive.box("icousel");
                      box.put("resetnumber", _phone.text);
                      // box.put('userid', uid);
                      // var repo = await user();
                      // 

                     

                      // box.put("userid", value)
                      // Navigator.of(context).pop();
                      SweetAlert.show(
                        context,
                        title: "Verification code sent",
                        // subtitle: "Sweet alert is pretty",
                        style: SweetAlertStyle.success,
                        showCancelButton:
                            false, // There won't be any cancel button
                        // buttons: false;// There won't be any confirm button
                      );

                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                         setState(() {
                      is_visible = true ;
                      is_visible1 = true;
                       is_visible2 = false;
                        is_visible3 = false;

                 });
                        // Route route =
                        //     MaterialPageRoute(builder: (c) => HomeScreen());
                        // Navigator.pushReplacement(context, route);
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
                        "Send code",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible:is_visible,
              child:  CustomTextField(
                isObsecure: false,
                data: Icons.lock,
                hintText: "Enter Verification code",
                controller: _password,
              ),
            ),
            SizedBox(height: 5),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Do you have an account? "),
            //     GestureDetector(
            //       onTap: () {
            //         Route route =
            //             MaterialPageRoute(builder: (c) => SignUpPage());
            //         Navigator.push(context, route);
            //       },
            //       child: Text(
            //         "SignUp",
            //         style: TextStyle(color: Theme.of(context).accentColor),
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(height: 5),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Do you have an account? "),
            //     GestureDetector(
            //       onTap: () {
            //         Route route =
            //             MaterialPageRoute(builder: (c) => SignUpPage());
            //         Navigator.push(context, route);
            //       },
            //       child: Text(
            //         "Forgot Password",
            //         style: TextStyle(color: Theme.of(context).accentColor),
            //       ),
            //     )
            //   ],
            // ),
            SizedBox(height: 10),
            Visibility(
              visible: is_visible1,
              child: GestureDetector(
                onTap: () async {
                  // _showMyDialog();
                  SweetAlert.show(
                    context,
                    title: "loading..",
                    subtitle: "please wait...",
                    showCancelButton: false,
                    style: SweetAlertStyle.loading,
                  );
                  if (_password.text != otp) {
                    Navigator.of(context).pop();
                    SweetAlert.show(context,
                        title: "Warning!",
                        subtitle: "Invalid code",
                        style: SweetAlertStyle.error,
                        showCancelButton: false);
                  } else if (_password.text == otp) {
                    // Navigator.of(context).pop();
                    SweetAlert.show(
                        context,
                        title: "Verification successful",
                        // subtitle: "Sweet alert is pretty",
                        style: SweetAlertStyle.success,
                        showCancelButton:
                            false, // There won't be any cancel button
                        // buttons: false;// There won't be any confirm button
                      );

                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                        Route route =
                            MaterialPageRoute(builder: (c) => Newpass());
                        Navigator.pushReplacement(context, route);
                      });
                  } else {
                    var resp;
                    try {
                      resp = await sendotp();
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
                      print(resp);
                      print(resp[0]["name"]);
                      setState(() {
                        uid = resp[0]['id'];
                        mymess = "login successful";
                      });
                      print(uid);
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
                        "Verify",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
             SizedBox(height: 20),
            Visibility(
              visible:is_visible1,
              child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn't recieve code? "),
                GestureDetector(
                  onTap: () {
                    setState(() {
                     setState(() {
                      is_visible = false ;
                      is_visible1 = false;
                       is_visible2 = true;
                        is_visible3 = true;

                 });

                 });
                  },
                  child: Text(
                    "Resend code",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                )
              ],
            ),),
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
