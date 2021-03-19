import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:student/dbhelper/database-helper.dart';
import 'package:student/fornt/front.dart';
import 'package:student/models/user.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:spllogin/dbhelper/database-helper.dart';
// import 'package:spllogin/models/user.dart';

import 'Registerform.dart';

// import 'HomePage.dart';

class LoginFormValidation extends StatefulWidget {
  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<LoginFormValidation> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }

  bool _isLoading = false;
  String emailid, pass, userna;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          // autovalidate: true, //check for validation while typing
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                          'assets/images/satvat_modified_logo.png')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter username'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                  ]),
                  controller: username,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                    EmailValidator(errorText: "Enter valid email id"),
                  ]),
                  controller: email,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                    MinLengthValidator(6,
                        errorText: "Password should be atleast 6 characters"),
                    MaxLengthValidator(15,
                        errorText:
                            "Password should not be greater than 15 characters")
                  ]),
                  controller: password,
                  //validatePassword,        //Function to check validation
                ),
              ),
              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () async {
                    if (formkey.currentState.validate()) {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => HomePage()));
                      print("Validated");
                      emailid = email.text;
                      pass = password.text;
                      userna = username.text;
                      // ignore: unused_local_variable
                      String flagLogged = "logged";
                      _isLoading = true;
                      formkey.currentState.save();
                      var user =
                          new User(userna, emailid, pass, null, null, null);
                      var db = new DatabaseHelper();
                      var userRetorno =
                          new User(null, null, null, null, null, null);
                      userRetorno = await db.selectUser(user);

                      if (userRetorno != null) {
                        flagLogged = "logged";
                        // savePref(emailid, pass, userna);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Frontpage()));
                      } else {
                        flagLogged = "not";
                      }
                    } else {
                      print("Not Validated");
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              InkWell(
                child: Text('New User? Create Account'),
                onTap: () {
                  // void navigate(BuildContext context, String text) {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>  RegisterFormValidation(
                  //                 text: text)));
                  // }

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //            n('Registeration')));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // savePref(String user, String pass, String name) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     preferences.setString("emailid", emailid);
  //     preferences.setString("pass", pass);
  //     preferences.setString("name", userna);
  //     print(' print(userna);---------------------------------');
  //     print(userna);

  //     // ignore: deprecated_member_use
  //     preferences.commit();
  //   });
  // }
}
