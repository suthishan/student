import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/dbhelper/database-helper.dart';
import 'package:student/models/user.dart';
import 'package:student/pages/LoginForm.dart';
// import 'package:spllogin/dbhelper/database-helper.dart';
// import 'package:spllogin/models/user.dart';
// import 'package:spllogin/pages/LoginForm.dart';

// import 'HomePage.dart';

class RegisterFormValidation extends StatefulWidget {
  RegisterFormValidation(String s);

  @override
  _RegisterFormValidationState createState() => _RegisterFormValidationState();
}

class _RegisterFormValidationState extends State<RegisterFormValidation> {
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
  String userna, emailid, pass, age, deg, univ;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ages = TextEditingController();
  TextEditingController degree = TextEditingController();
  TextEditingController university = TextEditingController();
  final String name;
  const RegisterFormValidation(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(name),
        // title: Text("Register Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          // autovalidate: true, //check for validation while typing
          key: formkey,
          child: Column(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(top: 60.0),
              //   child: Center(
              //     child: Container(
              //         width: 150,
              //         height: 150,
              //         child: Image.asset(
              //             'assets/images/satvat_modified_logo.png')),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
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
              Container(
                padding: EdgeInsets.all(10),
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
              Container(
                padding: const EdgeInsets.all(10),
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

              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'age',
                      hintText: 'age'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                  ]),
                  controller: ages,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'degree',
                      hintText: 'degree'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                  ]),
                  controller: degree,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'university',
                      hintText: 'university'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                  ]),
                  controller: university,
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    if (formkey.currentState.validate()) {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => HomePage()));
                      print("Validated");
                      userna = username.text;
                      pass = password.text;
                      emailid = email.text;
                      age = ages.text;
                      deg = degree.text;
                      univ = university.text;
                      setState(() {
                        _isLoading = true;
                        formkey.currentState.save();
                        var user =
                            new User(userna, emailid, pass, age, deg, univ);
                        var db = new DatabaseHelper();
                        db.saveUser(user);
                        _isLoading = false;
                        savePref(emailid, pass, userna, age, deg, univ);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => LoginFormValidation()));
                        // Navigator.of(context).pushNamed("/login");
                      });
                    } else {
                      print("Not Validated");
                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  savePref(String user, String pass, String name, String age, String deg,
      String univ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("emailid", emailid);
      preferences.setString("pass", pass);
      preferences.setString("name", userna);
      preferences.setString("ages", age);
      preferences.setString("degree", deg);
      preferences.setString("university", univ);

      // ignore: deprecated_member_use
      preferences.commit();
    });
  }
}
