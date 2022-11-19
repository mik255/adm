

import 'package:adm/models/story.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../models/product.model.dart';
import '../../../shared/widgets/switchWithTitle.dart';

class ListOfProducts extends StatefulWidget {
   ListOfProducts({Key? key,required this.indexOnChangeCallBack,required this.products}) : super(key: key);

       List<Product> products;
  final Function(bool,int)indexOnChangeCallBack;

  @override
  State<ListOfProducts> createState() => _ListOfProductsState();
}

class _ListOfProductsState extends State<ListOfProducts> {

  

  @override
  void dispose() {
    widget.products = widget.products.map((e) => e..active = false).toList();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
     children: [
      ...List.generate(widget.products.length, (index) => SwitchWithTitle(
                  title: widget.products[index].name,
                  initialValue: widget.products[index].active,
                  onChange: (v){
                     setState(() {
                    widget.products[index].active = v;
                    widget.indexOnChangeCallBack.call(v,index);
                    });
                  },
                ),)
     ],
    );
  }
}