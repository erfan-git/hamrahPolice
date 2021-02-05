import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamrahpolice1/components/inputFieldArea.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _name;
  String _family;
  String _nationalCode;
  String _bornPlace;
  var _bornYear;
  String _username;
  String _password;

  onSaveName(String value) {
    _name = value;
  }

  onSaveFamily(String value) {
    _family = value;
  }

  onSaveNationalCode(String value) {
    _nationalCode = value;
  }

  onSaveBornPlace(String value) {
    _bornPlace = value;
  }

  onSaveBornYear(String value) {
    _bornYear = value;
  }

  onSaveUsername(String value) {
    _username = value;
  }

  onSavePassword(String value) {
    _password = value;
  }

  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background_signUp.png"),
                ),
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
                          hint: 'نام',
                          obscure: false,
                          icon: Icons.person_rounded,
                          validator: (String value) {
                            if (value.length == 0) {
                              return "نام هنوز وارد نشده است";
                            }
                          },
                          margin: 4.0,
                          onSaveValue: onSaveName,
                        ),
                        InputFieldArea(
                          hint: 'نام خانوادگی',
                          obscure: false,
                          icon: Icons.supervisor_account,
                          validator: (String value) {
                            if (value.length == 0) {
                              return "نام خانوادگی هنوز وارد نشده است";
                            }
                          },
                          margin: 4.0,
                          onSaveValue: onSaveFamily,
                        ),
                        InputFieldArea(
                          hint: 'کد ملی',
                          obscure: false,
                          icon: Icons.account_box,
                          validator: (String value) {
                            if (value.length == 0) {
                              return "کد ملی هنوز وارد نشده است";
                            }
                            if (value.length <= 9 || value.length > 10) {
                              return "کد ملی اشتباه است";
                            }
                          },
                          margin: 4.0,
                          onSaveValue: onSaveNationalCode,
                        ),
                        InputFieldArea(
                          hint: 'محل تولد',
                          obscure: false,
                          icon: Icons.add_location_outlined,
                          validator: (String value) {},
                          margin: 4.0,
                          onSaveValue: onSaveBornPlace,
                        ),
                        InputFieldArea(
                          hint: 'سال تولد',
                          obscure: false,
                          icon: Icons.calendar_today_outlined,
                          validator: (String value) {
                            if (value.length == 0) {
                              return "سال تولد هنوز وارد نشده است";
                            }
                          },
                          margin: 4.0,
                          onSaveValue: onSaveBornYear,
                        ),
                        InputFieldArea(
                          hint: 'ایمیل',
                          obscure: false,
                          icon: Icons.email_outlined,
                          margin: 4.0,
                          validator: (String value) {
                            if (value.length == 0) {
                              return "نام خانوادگی هنوز وارد نشده است";
                            }
                            if (!isEmail(value)) {
                              return 'ایمیل وارد شده معتبر نیست';
                            }
                          },
                          onSaveValue: onSaveUsername,
                        ),
                        InputFieldArea(
                          hint: 'پسورد',
                          obscure: false,
                          margin: 4.0,
                          icon: Icons.lock_open,
                          validator: (String value) {
                            if (value.length <= 8) {
                              return "طول پسورد باید حداقل 8 کاراکتر باشد";
                            }
                          },
                          onSaveValue: onSavePassword,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                  onTap: () {
                    if (_formkey.currentState.validate()) {
                      _formkey.currentState.save();
                      sendDataToServer();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 220,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white,
                    ),
                    child: Text(
                      'عضویت',
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        fontFamily: 'IranSans',
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future sendDataToServer() async {
    final response = await http.post('http://127.0.0.1:8000/api/register', body: {
      'name': _name,
      'family': _family,
      'nationalcode': _nationalCode,
      'bornplace': _bornPlace,
      'bornyear': _bornYear,
      'email': _username,
      'password': _password
    },headers: _setHeaders());
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 201) {
      Navigator.of(context).pushNamed('/');
      storeUserData(responseBody);
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'مشکلی پیش آمده!',
            style:
                TextStyle(fontFamily: 'IranSans', fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
  }

  _setHeaders() => {
    // 'Content-type': 'application/json',
    'type': 'bearer',
    'Accept': 'application/json',
    // 'Authorization' : 'Bearer $token'
  };

  storeUserData(Map userData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user.api_token', userData['api_token']);
  }
}
