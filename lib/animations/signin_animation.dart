import 'package:flutter/material.dart';

class SignInAnimation extends StatelessWidget {
  final Animation<double> controller;
  final Animation<double> buttonSqueezeAnimatoin;
  final Animation<double> buttonZoomOut;

  SignInAnimation({this.controller})
      : buttonSqueezeAnimatoin = Tween(
          begin: 280.0,
          end: 60.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Interval(0.0, 0.150)),
        ),
        buttonZoomOut = Tween(
          begin: 70.0,
          end: 1000.0,
        ).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval(0.550, 0.999, curve: Curves.bounceOut)),
        );

  Widget _animationBuilder(BuildContext context, Widget child) {
    return buttonZoomOut.value <= 300
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 220,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
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
          )
        : Container(
            width: buttonZoomOut.value,
            height: buttonZoomOut.value,
            decoration: BoxDecoration(
                shape: buttonZoomOut.value < 500
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                color: Colors.white),
          );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _animationBuilder);
  }
}
