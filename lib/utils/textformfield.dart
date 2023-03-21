import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  var controller;
  var keyboardType;
  var nextfield;
  var hintText;
  var initformatter;
  var maxLines;
  var validator;
  Color? color;
  var cursorColor;
  var style;
  var obscureText;
  var suffixIcon;


  textfield(
      {Key? key,
        required this.hintText,
        required this.controller,
        required this.keyboardType,
        required this.nextfield,
        this.initformatter,
        this.maxLines,
        this.color,
        this.validator,
        this.cursorColor,
        this.style,
        this.obscureText,
        this.suffixIcon,

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: cursorColor,
      validator: validator,
      obscureText: obscureText?? false,
      maxLines: maxLines,
      style: style,
      inputFormatters: initformatter,
      textInputAction: nextfield,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: (color == null) ? Colors.white : color,
        hintStyle:  TextStyle(fontSize: 14,color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        border: OutlineInputBorder(),
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
