import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            // width: size.width,
            // height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_main.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}