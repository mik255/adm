import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'customSwitch.dart';

class SwitchWithTitle extends StatefulWidget {
  SwitchWithTitle({
    Key? key,
    required this.initialValue,
    required this.onChange,
    required this.title,
  }) : super(key: key);
  bool initialValue;
  Function(bool)? onChange;
  String title;

  @override
  State<SwitchWithTitle> createState() => _SwitchWithTitleState();
}

class _SwitchWithTitleState extends State<SwitchWithTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
     
        Checkbox(value: widget.initialValue, onChanged: (v){
           setState(() {
            widget.initialValue = v??false;
             widget.onChange?.call(v??false);
           });
          } ),
             Text(widget.title),
     //   CustomSwitch(
      //    initialValue: widget.initialValue,
      //    onChange: (v){
       //    setState(() {
       //     widget.initialValue = v;
       //      widget.onChange?.call(v);
        //   });
       //   } 
       // ),
      ],
    );
  }
}
