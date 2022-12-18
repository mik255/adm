


import 'package:flutter/material.dart';

import '../../../models/user.model.dart';
import '../../../shared/widgets/switchWithTitle.dart';

class ListOfUsers extends StatefulWidget {
   ListOfUsers({Key? key,required this.indexOnChangeCallBack,required this.users}) : super(key: key);

       List<User> users;
       final Function(bool,int)indexOnChangeCallBack;

  @override
  State<ListOfUsers> createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {

  

  @override
  void dispose() {
    widget.users = widget.users.map((e) => e..active = false).toList();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
     children: [
      ...List.generate(widget.users.length, (index) => SwitchWithTitle(
                  title: widget.users[index].nome,
                  initialValue: widget.users[index].active,
                  onChange: (v){
                     setState(() {
                    widget.users[index].active = v;
                    widget.indexOnChangeCallBack.call(v,index);
                    });
                  },
                ),)
     ],
    );
  }
}