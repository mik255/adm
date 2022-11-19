

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

customToast(String text){
   Fluttertoast.showToast(
          msg: text,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
}