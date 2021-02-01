import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hamrahpolice1/components/inputFieldArea.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;

class LogIn1 extends StatefulWidget {
  @override
  _LogIn1State createState() => _LogIn1State();
}

class _LogIn1State extends State<LogIn1> with SingleTickerProviderStateMixin {
  // AnimationController _loginButtonController;
  String _username;
  String _password;

  onSaveUsername(String value) {
    _username = value;
  }

  onSavePassword(String value) {
    _password = value;
  }

  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _loginButtonController = AnimationController(vsync: this,duration: Duration(milliseconds: 3000));
  // }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _loginButtonController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background_logIn.png")),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        InputFieldArea(
                          hint: 'ایمیل کاربری',
                          obscure: false,
                          icon: Icons.person_outline,
                          validator: (String value) {
                            if (value.length == 0) {
                              return "ایمیل هنوز وارد نشده است";
                            }
                            if (!isEmail(value)) {
                              return 'ایمیل وارد شده معتبر نیست';
                            }
                          },
                          margin: 15.0,
                          onSaveValue: onSaveUsername,
                        ),
                        InputFieldArea(
                          validator: (String value) {
                            if (value.length <= 8) {
                              return "طول پسورد باید حداقل 8 کاراکتر باشد";
                            }
                          },
                          hint: 'پسورد',
                          obscure: true,
                          icon: Icons.lock_open,
                          margin: 15.0,
                          onSaveValue: onSavePassword,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signUp');
                            },
                            child: Text(
                              'آیا هیچ اکانتی ندارید؟ عضویت',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'IranSans',
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              if (_formkey.currentState.validate()) {
                                _formkey.currentState.save();
                                Navigator.of(context).pushNamed('/signUp');
                                // sendDataToServer();
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              width: 220,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.white,
                              ),
                              child: Text(
                                'ورود',
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  fontFamily: 'IranSans',
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future sendDataToServer() async {
    final response = await http
        .post('url', body: {'email': _username, 'password': _password});
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      storeUserData(responseBody['data']);
      Navigator.of(context).pushNamed('/');
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            responseBody['data'],
            style:
                TextStyle(fontFamily: 'IranSans', fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
  }

  storeUserData(Map userData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user.api_token', userData['api_token']);
    await prefs.setString('user.user_id', userData['user_id']);

  }
}
