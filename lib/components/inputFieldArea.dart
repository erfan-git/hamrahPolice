import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final validator;
  final margin;
  final onSaveValue;

  InputFieldArea({this.hint, this.obscure, this.icon, this.validator,this.margin,this.onSaveValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: margin),
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(
      //       width: 0.9,
      //       color: Colors.white30,
      //     ),
      //   ),
      // ),
      child: TextFormField(
        onSaved: onSaveValue,
        validator: validator,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.amber),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white30),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white,width: 2),
          ),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
              color: Colors.white, fontSize: 17, fontFamily: 'IranSans'),
          contentPadding:
              EdgeInsets.only(top: 8, right: 0, bottom: 8, left: 5),
        ),
      ),
    );
  }
}
