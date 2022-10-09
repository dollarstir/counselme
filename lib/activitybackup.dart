import "package:flutter/material.dart";

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ActivityTile(),
        ActivityTileInstant(),
        ActivityTileApproved(),
        ActivityTileInstantApproved()
      ]),
    );
  }
}

class ActivityTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        width: double.infinity - 40,
        height: screenheight * 0.25,
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(0, 5), color: Colors.grey[200], blurRadius: 10),
        ], borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Row(children: [
          Column(children: [
            Container(
                height: 85,
                margin: EdgeInsets.only(left: 10, top: 10),
                width: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.red,
                ),
                child: Icon(
                  Icons.date_range,
                  size: 40,
                  color: Colors.white,
                )),
            Container(
              height: 40,
              width: 85,
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.only(left: 10, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[200],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "31 July, 2021",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "2:00 PM",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ]),
            )
          ]),
          SizedBox(width: 10),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("You will be assigned a counsellor shortly",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Text(
                  "Health Counsellor",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: Theme.of(context).accentColor,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text("Legon",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 35,
                          width: 95,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.greenAccent,
                          ),
                          child: Center(
                            child: Text("Pending",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 35,
                          width: 95,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.redAccent,
                          ),
                          child: Center(
                            child: Text("Cancel",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                          )),
                    )
                  ],
                )
              ])
        ]));
  }
}

class ActivityTileInstant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        width: double.infinity - 40,
        height: screenheight * 0.25,
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(0, 5), color: Colors.grey[200], blurRadius: 10),
        ], borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Row(children: [
          Column(children: [
            Container(
                height: 85,
                margin: EdgeInsets.only(left: 10, top: 10),
                width: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.cyan,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      //size: 40,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.data_usage,
                      //size: 40,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.person,
                      //size: 40,
                      color: Colors.white,
                    ),
                  ],
                )),
            Container(
              height: 40,
              width: 85,
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.only(left: 10, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[200],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "31 July, 2021",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "2:00 PM",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ]),
            )
          ]),
          SizedBox(width: 10),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("You will be assigned a counsellor shortly",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Text(
                  "Health Counsellor",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: Theme.of(context).accentColor,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text("Legon",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 35,
                          width: 95,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.greenAccent,
                          ),
                          child: Center(
                            child: Text("Pending",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 35,
                          width: 95,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.redAccent,
                          ),
                          child: Center(
                            child: Text("Cancel",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                          )),
                    )
                  ],
                )
              ])
        ]));
  }
}

class ActivityTileApproved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Stack(children: [
      Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          width: double.infinity - 40,
          height: screenheight * 0.25,
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), color: Colors.grey[200], blurRadius: 10),
          ], borderRadius: BorderRadius.circular(16), color: Colors.white),
          child: Row(children: [
            Column(children: [
              Container(
                  height: 85,
                  margin: EdgeInsets.only(left: 10, top: 10),
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.red,
                  ),
                  child: Icon(
                    Icons.date_range,
                    size: 40,
                    color: Colors.white,
                  )),
              Container(
                height: 40,
                width: 85,
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.only(left: 10, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[200],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "31 July, 2021",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "2:00 PM",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ]),
              )
            ]),
            SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hawa Adams",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Text(
                    "Health Counsellor",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: Theme.of(context).accentColor,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text("Legon",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: 35,
                            width: 85,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Theme.of(context).accentColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.call,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text("Call",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: 35,
                            width: 85,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey[300],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text("Chat",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                              ],
                            )),
                      )
                    ],
                  )
                ])
          ])),
      Positioned(
        right: 20,
        top: 10,
        child: Container(
            height: 20,
            width: 60,
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.only(left: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.greenAccent,
            ),
            child: Center(
              child: Text("Approved",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            )),
      )
    ]);
  }
}

class ActivityTileInstantApproved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Stack(children: [
      Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          width: double.infinity - 40,
          height: screenheight * 0.25,
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), color: Colors.grey[200], blurRadius: 10),
          ], borderRadius: BorderRadius.circular(16), color: Colors.white),
          child: Row(children: [
            Column(children: [
              Container(
                  height: 85,
                  margin: EdgeInsets.only(left: 10, top: 10),
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.cyan,
                  ),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      //size: 40,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.data_usage,
                      //size: 40,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.person,
                      //size: 40,
                      color: Colors.white,
                    ),
                  ],
                )),
              Container(
                height: 40,
                width: 85,
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.only(left: 10, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[200],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "31 July, 2021",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "2:00 PM",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ]),
              )
            ]),
            SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hawa Adams",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Text(
                    "Health Counsellor",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: Theme.of(context).accentColor,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text("Legon",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: 35,
                            width: 85,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Theme.of(context).accentColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.call,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text("Call",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: 35,
                            width: 85,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey[300],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text("Chat",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                              ],
                            )),
                      )
                    ],
                  )
                ])
          ])),
      Positioned(
        right: 20,
        top: 10,
        child: Container(
            height: 20,
            width: 60,
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.only(left: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.greenAccent,
            ),
            child: Center(
              child: Text("Approved",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            )),
      )
    ]);
  }
}
