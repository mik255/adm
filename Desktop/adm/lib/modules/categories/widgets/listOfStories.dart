

import 'package:adm/models/story.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../shared/widgets/switchWithTitle.dart';

class ListOfStories extends StatefulWidget {
   ListOfStories({Key? key,required this.indexOnChangeCallBack,required this.stories}) : super(key: key);
  
   List<Story> stories;
  final Function(bool,int)indexOnChangeCallBack;

  @override
  State<ListOfStories> createState() => _ListOfStoriesState();
}

class _ListOfStoriesState extends State<ListOfStories> {

  @override
  void dispose() {
    widget.stories = widget.stories.map((e) => e..active = false).toList();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
     children: [
      ...List.generate(widget.stories.length, (index) => SwitchWithTitle(
                  title: widget.stories[index].name,
                  initialValue: widget.stories[index].active,
                  onChange: (v){
                     setState(() {
                    widget.stories[index].active = v;
                    widget.indexOnChangeCallBack.call(v,index);
                    });
                  },
                ),)
     ],
    );
  }
}