import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/dbhelper/database-helper.dart';
// import 'package:spllogin/dbhelper/database-helper.dart';

class WelcomePag extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePag> {
  String email, password, user, age, deg, univ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString("emailid");
      print(email);
      password = preferences.getString("pass");
      user = preferences.getString("name") ?? 'nla';
      print('print(user);');
      print(user);
      age = preferences.getString("ages");
      deg = preferences.getString("degree");
      univ = preferences.getString("university");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Dashboard Page"),
        ),
        body: SingleChildScrollView(
            child: Container(
                //margin:EdgeInsets.only(top:ScreenUtil.statusBarHeight),
                child: Column(
          children: <Widget>[
            // ListView(
            //   children: <Widget>[
            //     Card(
            //       child: ListTile(
            //         trailing: Icon(Icons.more),
            //         title: Text('One-line with leading widget'),
            //       ),
            //     ),
            //   ],
            // ),
            Card(
              elevation: 10,
              color: Colors.blue[300],
              shadowColor: Colors.black,
              child: ListTile(
                leading: Icon(Icons.person_pin_circle),
                title: Text(user, style: TextStyle(fontSize: 18)),
                subtitle: Text(email, style: TextStyle(fontSize: 18)),
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.all(30),
            //   child: Text(user, style: TextStyle(fontSize: 18)),
            // ),
            // Padding(
            //   padding: EdgeInsets.all(30),
            //   child: Text(email, style: TextStyle(fontSize: 18)),
            // ),
            // Padding(
            //   padding: EdgeInsets.all(30),
            //   child: Text(password, style: TextStyle(fontSize: 18)),
            // ),
            // Padding(
            //   padding: EdgeInsets.all(30),
            //   child: Text(age, style: TextStyle(fontSize: 18)),
            // ),
            // Padding(
            //   padding: EdgeInsets.all(30),
            //   child: Text(deg, style: TextStyle(fontSize: 18)),
            // ),
            // Padding(
            //   padding: EdgeInsets.all(30),
            //   child: Text(univ, style: TextStyle(fontSize: 18)),
            // ),
            // InkWell(
            //     child: Text('get all'),
            //     onTap: () {
            //       DatabaseHelper dbHelper = new DatabaseHelper();
            //       dbHelper.retrieveUser();
            //     })
          ],
        ))));
  }
}
