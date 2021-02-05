import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  startTime() {
    var _duration = Duration(seconds: 1);
    //در ویجت تایمر دو ورودی میدهیم که اولی duration و دومی فانکشن کاری که قراره انجام بده است
    //از متد navigationPage بدون پرانتز استفاده کردیم تا در همان لحظه اجرا نشود و هر موقع تایمر تمام شد اجرا شود
    return Timer(_duration, navigationPage);
  }

  navigationPage() {
    checkLogin();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2df0f7),
      body: Container(
        width: 411.4,
        height: 683.4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff2DF0F7), Color(0xff0846F3)],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(-53.0, 322.0),
              child: Container(
                width: 600.0,
                height: 116.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(58.0),
                  color: const Color(0xffffffff),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(55.1, 96.0),
              child: Transform.rotate(
                angle: 0.0,
                child: Container(
                  width: 1000.8,
                  height: 140.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(105.0),
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(-45.0, 37.0),
              child: Container(
                width: 281.0,
                height: 267.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/logo3.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(-30.0, 358.0),
              child: SizedBox(
                width: 384.0,
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'IranSans',
                      fontSize: 26,
                      color: const Color(0xff000000),
                      height: 1.5862068965517242,
                      shadows: [
                        Shadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 10),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    children: [
                      TextSpan(
                        text: 'به ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'همراه',
                        style: TextStyle(
                          color: const Color(0xfffd0000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'پلیس',
                        style: TextStyle(
                          color: const Color(0xff0846f3),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' خوش آمدید',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(-100.2, 620.0),
              child: SizedBox(
                width: 238.0,
                child: Text(
                  ' چند لحظه صبر کنید . . .',
                  style: TextStyle(
                    fontFamily: 'IranSans',
                    fontSize: 16,
                    color: const Color(0xffe4e4e4),
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user.api_token');
    if(await checkConnectionInternet()){
      await checkApiToken(apiToken)
          ? Navigator.of(context).pushReplacementNamed('/')
          : Navigator.of(context).pushReplacementNamed('/login');
    }else{
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(hours: 2),

          content: GestureDetector(
            onTap: (){
              _scaffoldKey.currentState.hideCurrentSnackBar();
              checkLogin();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'از اتصال دستگاه به اینترنت مطمئن شوید',
                  style:
                  TextStyle(fontFamily: 'IranSans', fontWeight: FontWeight.w500),
                ),
                Icon(Icons.signal_wifi_off,color: Colors.white,)
              ],
            ),
          ),
        ),
      );

    }
  }

  Future<bool> checkConnectionInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);
  }

  Future<bool> checkApiToken(String apiToken) async{
    final response = await http.get('u?rl=${apiToken}',headers:{'type': 'bearer',} );
    return response.statusCode == 200;
  }
}
