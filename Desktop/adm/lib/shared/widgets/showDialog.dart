



import 'package:flutter/material.dart';

import 'customSwitch.dart';
import 'switchWithTitle.dart';
class DialogUtilState{}
class DialogUtilAdle extends DialogUtilState{}
class DialogUtilLoading extends DialogUtilState{}
class DialogUtilSucess extends DialogUtilState{}

class DialogUtilController extends ValueNotifier<DialogUtilState>{
  DialogUtilController(super.value);

void setLoading(){
  value = DialogUtilLoading();
}
void setSucess(){
  value = DialogUtilSucess();
}
void setAdle(){
  value = DialogUtilAdle();
}
}
class DialogUtil{
  DialogUtilController controller = DialogUtilController(DialogUtilAdle());
   showDialogUtil(BuildContext context,Widget content,{Function()? onSave,Function(bool)?
    continueCreate,String? buttomName,required String title}){
    
    return showDialog(
      context: context, builder: (context)=>ValueListenableBuilder(
        valueListenable: controller,
        builder: (context,state,child) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(title),
              InkWell(
                onTap: ()=>Navigator.of(context).pop(),
                child: Icon(Icons.close))
            ]),
          content: content,
          actions: [  
            SwitchWithTitle(title:'Continuar Criando',initialValue:false,onChange:continueCreate),
             Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: ()async{
                    controller.setLoading();
                    if(await onSave?.call()){
                       controller.setSucess();
                     Navigator.pop(context);
                    }
                    controller.setAdle();
                  }, child: Text(buttomName??'Salvar')),
                ),],);
        }
      ));
  }
}