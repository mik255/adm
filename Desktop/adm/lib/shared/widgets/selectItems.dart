import 'package:adm/shared/widgets/searchDropDown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SelectItems extends StatefulWidget {
  const SelectItems({Key? key, required this.items, required this.onSelect})
      : super(key: key);
  final List<String> items;
  final Function(int i) onSelect;

  @override
  State<SelectItems> createState() => _SelectItemsState();
}

class _SelectItemsState extends State<SelectItems> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        child: Center(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchDropDown(items: widget.items, onSelect: widget.onSelect),
                  )),
                  Divider(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 6,
                        children: <Widget>[
                       Chip(label: Text('text'))
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
