import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key, required this.title, required this.onChange,this.icon,this.initialText})
      : super(key: key);
  String title;
  IconData? icon;
  String? initialText;
  Function(String value) onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        initialValue: initialText,
        onChanged: onChange,
        decoration: InputDecoration(
          hintText: 'digite aqui',
          labelText: title,
          border: OutlineInputBorder(),
          suffixIcon: Icon(
            icon
          ),
        ),
      ),
    );
  }
}
