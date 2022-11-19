import 'package:adm/shared/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class SearchDropDown extends StatefulWidget {
  const SearchDropDown({Key? key,required this.items,required this.onSelect}) : super(key: key);
  final Function(int index) onSelect;
  final List<String> items;
  @override
  State<SearchDropDown> createState() => _SearchDropDownState();
}

class _SearchDropDownState extends State<SearchDropDown> {
  String hovered = '';
  String textValue = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 500,
      child: SingleChildScrollView(
        child: Column(children: [
          CustomTextField(title: 'Procurar Loja', onChange: (v){
            setState(() {
               textValue = v;
            });
          }),
          ...widget.items.where((e)=>textValue==''?true:textValue.toLowerCase().contains(e.toLowerCase())).
           map((e) => InkWell(
            onTap: (){
              widget.onSelect.call(widget.items.indexOf(e));
            },
            child: MouseRegion(
            onHover: (v){
              setState(() {
                hovered =e;
              });
            },
            child: Row(
              children: [
                Expanded(child: Container(
                  color: e==hovered? Colors.grey:Colors.transparent,
                  height: 50,child: Text(e),)),
              ],
            ),
          ),)).toList()]),
      ),
    );
  }
}