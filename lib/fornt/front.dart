import 'package:flutter/material.dart';
import 'package:student/pages/DashboardPage.dart';
import 'package:student/pages/Registerform.dart';

class Frontpage extends StatefulWidget {
  @override
  FrontpageState createState() => FrontpageState();
}

class FrontpageState extends State<Frontpage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text("dashboard"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              //    void navigate(BuildContext context, String text){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SignleCardInputScreen(text: text,)));
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => WelcomePag()));
            },
          )
        ],
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100,
            child: Card(
              elevation: 10,
              child: FlatButton(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Icon(Icons.add), Text("Add")],
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          RegisterFormValidation('Add details'),
                    ),
                  ),
                },
              ),
            ),
          ),
          SizedBox(
            width: 40,
          ),
          // Column(
          //   children: <Widget>[
          //     Container(
          //       child: Card(
          //         elevation: 10,
          //         child: FlatButton(
          //           padding: EdgeInsets.all(10.0),
          //           child: Column(
          //             children: <Widget>[Icon(Icons.list), Text("list")],
          //           ),
          //           onPressed: () => {},
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       height: 20,
          //     ),
          //   ],
          // ),
          Container(
            height: 100,
            child: Card(
              elevation: 10,
              child: FlatButton(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Icon(Icons.list), Text("List")],
                ),
                onPressed: () => {},
              ),
            ),
          ),
        ],
      )),
    );
  }
}
