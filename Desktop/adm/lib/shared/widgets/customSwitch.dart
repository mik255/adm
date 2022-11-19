import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomSwitch extends StatefulWidget {
  CustomSwitch({Key? key, required this.initialValue,required this.onChange}) : super(key: key);
  bool initialValue;
  Function(bool)? onChange;
  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: widget.initialValue,
        onChanged: (v) {
          setState(() {
            widget.initialValue = v;
            widget.onChange?.call(v);
          });
        });
  }
}
