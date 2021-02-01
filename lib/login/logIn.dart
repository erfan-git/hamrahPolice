import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String username = '';

  @override
  Widget build(BuildContext context) {
    String _username;
    String _password;

    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    Widget _buildUsername() {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'نام کاربری'
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (String value){
          if(value.isEmpty){
            return 'نام کاربری را وارد کنید';
          }
          if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)){
            return 'ایمیل وارد شده صحیح نیست';
          }
          return null;
        },
        onSaved: (String value){
          _username = value;
        },
      );
    }

    Widget _buildPassword() {
      return TextFormField(
        decoration: InputDecoration(
            labelText: 'رمزعبور',
            // border: OutlineInputBorder(),
            //     labelStyle: TextStyle(fontSize: 15,color: Colors.white)
        ),
        keyboardType: TextInputType.text,
        validator: (String value){ 
          if(value.isEmpty){
            return ' رمز عبور را وارد کنید';
          }else{
            return null;
          }
        },
        onSaved: (String value){
          _password = value;
        },
      );;
    }

    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background_logIn.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height / 4,
                width: size.width,
                alignment: Alignment.center,
                child: SizedBox(
                  width: size.width / 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Text(
                          'ورود',
                          style: TextStyle(
                              fontFamily: 'IranSans',
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 37,right: 37),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      _buildUsername(),
                      _buildPassword(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              RaisedButton(
                child: Text(
                  'ورود',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    fontFamily: 'IranSans',
                  ),
                ),
                onPressed: (){
                  if(!_formkey.currentState.validate()){
                    return ;

                  }
                  _formkey.currentState.save();

                  print(_username);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
