import 'dart:convert';
import 'dart:io';
import 'dart:async';

import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:icounselgh/HomePage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _current = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _repeatPassword = TextEditingController();

  var cpass;
  var newpass;

  Future Changepass() async {
    Box box = Hive.box("icousel");
    
    var userid = box.get("userid");
   

    String bookurl = "https://icounselgh.net/changepass";
    var response = await http.post(Uri.parse(bookurl), body: {
      "userid": userid,
      "cpass": cpass,
      "newpass": newpass,
      
    });
    var result = jsonDecode(response.body);
    print(result);
    return result;
  }
  @override
  Widget build(BuildContext context) {
    //double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: Text("change password",style: GoogleFonts.montserrat(
                                    fontSize: 17, fontWeight: FontWeight.w500,color: Colors.orange),), backgroundColor: Colors.white),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                CustomPasswordTextField(
                  //controller: ,
                  controller: _current,
                  hintText: "Current Password",
                  data: Icons.lock,
                  isObsecure: true,
                ),
                SizedBox(
                  height: 3,
                ),
                CustomPasswordTextField(
                  //controller: ,
                  controller: _newPassword,
                  hintText: "New Password",
                  data: Icons.lock,
                  isObsecure: true,
                ),
                CustomPasswordTextField(
                  //controller: ,
                  controller: _repeatPassword,
                  hintText: "Repeat Password",
                  data: Icons.lock,
                  isObsecure: true,
                ),
                SizedBox(height: 230),
                GestureDetector(
                  onTap: () async{


                    setState(() {
                      cpass = _current.text;
                      newpass = _newPassword.text;
                    });
                    SweetAlert.show(context,
                  title: "Loading ..",
                  subtitle: "Please wait...",
                  style: SweetAlertStyle.loading,
                  );
                  // print(date2.toString());
                  if(_repeatPassword.text != _newPassword.text){
                     Navigator.of(context).pop();
                      SweetAlert.show(
                      context,
                      title: "Sorry",
                      subtitle: "Password do not match",
                      style: SweetAlertStyle.error,
                    );
                  }
                  else if(_newPassword.text == "" || _repeatPassword.text == "" || _current.text == "" ){
                     Navigator.of(context).pop();
                    SweetAlert.show(
                      context,
                      title: "oops!",
                      subtitle: "All field must be filed",
                      style: SweetAlertStyle.error,
                    );

                  }
                  else{
                    var rep = await Changepass();
                  
                  // print(rep);
                  if (rep == "all field required") {
                    // Navigator.of(context).pop();
                    SweetAlert.show(
                      context,
                      title: "Sorry",
                      subtitle: "Fill all fields",
                      style: SweetAlertStyle.error,
                    );
                  } else if (rep == "Wrong password") {
                    //  Navigator.of(context).pop();
                    SweetAlert.show(
                      context,
                      title: "Sorry",
                      subtitle: "Enter correct current password ",
                      style: SweetAlertStyle.error,
                    );
                  }

                  else if(rep =="password changed succeesfully"){
                    SweetAlert.show(context,
                    title: "Congrats!!",
                    subtitle: 'password updated succeesfully',
                    style: SweetAlertStyle.success,
                    );

                    Future.delayed(Duration(seconds: 3),(){
                       Navigator.of(context).pop();
                      Route route =
                          MaterialPageRoute(builder: (c) => HomeScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  }
                  else{
                    SweetAlert.show(context,
                    title: 'Sorry',
                    subtitle: 'Failed to change password',
                    style: SweetAlertStyle.error,
                    );
                  }
                  }
                    // Route route = MaterialPageRoute(builder: (c) => SignUpPage2());
                    // Navigator.push(context, route);
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
