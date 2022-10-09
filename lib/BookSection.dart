import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:icounselgh/dt.dart';
import 'package:sweetalert/sweetalert.dart';

class BookSession extends StatefulWidget {
  @override
  _BookSessionState createState() => _BookSessionState();
}

class _BookSessionState extends State<BookSession> {
  TextEditingController _region = TextEditingController();
  TextEditingController _type = TextEditingController();

  String mytpe;
  String myloc;

  var dbval = 1;
  var dbval1 = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("book a session"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20),
              Text(
                "Schedule a date with a counsellor",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Container(
                height: 150,
                margin: EdgeInsets.only(left: 10, top: 10),
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.red,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.date_range,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("Book a session",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))
                    ]),
              ),
              SizedBox(height: 20),
              // CustomTextField(
              //   //controller: ,
              //   controller: _type,
              //   hintText: "Choose type of counsellor",
              //   data: Icons.person,
              //   isObsecure: false,
              // ),

              DropdownButton(
                value: dbval,
                
                items: [

                  DropdownMenuItem(
                    child: Text("Select Counselling need"),
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
                      mytpe = "Select Counselling need";
                    });
                  }
                  else if (val == 2) {
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
              SizedBox(
                height: 3,
              ),

              DropdownButton(
                hint: Text("Select counsellors location "),
                value: dbval1,
                items: [
                   DropdownMenuItem(
                    child: Text("Select counsellors location "),
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
                      myloc = "Select counsellors location ";
                    });
                  }
                  else if (val == 2) {
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

                  else if (val == 18) {
                    setState(() {
                      myloc = "International";
                    });
                  }
                },
               
              ),
              // CustomTextField(
              //   //controller: ,
              //   controller: _region,
              //   hintText: "Choose Region",
              //   data: Icons.place,
              //   isObsecure: false,
              // ),
              SizedBox(height: 90),
              GestureDetector(
                onTap: () {
                  Box box = Hive.box("icousel");
                  box.put("btype", mytpe);
                  box.put("bloc",myloc);
                  Route route = MaterialPageRoute(builder: (c) => Choosedt());
                  Navigator.push(context, route);
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
            ]),
      ),
    );
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
