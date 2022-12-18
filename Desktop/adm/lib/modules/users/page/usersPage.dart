

import 'package:adm/models/user.model.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../shared/widgets/circurarLoading.dart';
import '../../../shared/widgets/showDialog.dart';
import '../../../shared/widgets/table/TableUiController.dart';
import '../../../shared/widgets/table/states.dart';
import '../../../shared/widgets/table/widget_table.dart';
import '../../receipts/page/receiptListPage.dart';
import '../store/store.dart';
import '../widgets/editUsers.dart';

class UsersRegister extends StatelessWidget {
  const UsersRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    
 return Scaffold(
   body: ValueListenableBuilder<UserState>(
     valueListenable: UserController.instance,
     builder: (context, state,child) {
      TableUiController tableUiControllerRequiriments =
          TableUiController(TableUiState(headers: [
        TableHeader(value: const Text("Nome",)),
        TableHeader(value: const Text("Senha")),
        TableHeader(value: const Text("CNPJ")),
        TableHeader(value: const Center(child: Text("Atividade",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)))),
        TableHeader(
            value: Row(
          children: const [
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 48.0),
              child: Text("Ações",style: TextStyle(color: Colors.white)),
            ),
          ],
        )),
      ], tableDataList: [
        ...Constants.instance.users.map((e) => [
          TableCellRow(value: Text(e.nome)),
          TableCellRow(value: Text(e.password)),
          TableCellRow(value: Text(e.cnpj)),
          TableCellRow(value: Checkbox(value: e.isAtivo==1,onChanged: (v){},)),
          TableActions(actions: [
            InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: () {
                     DialogUtil().showDialogUtil(title:'Formulario User',context, EditUsers(user: e,),
                     onSave: (() => UserController.instance.updateUser(e)));
                  },
              child: const Padding(
                padding: EdgeInsets.all(2),
                child: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: () {
                 DialogUtil().showDialogUtil(
                              title: 'Formulario Categoria',
                              buttomName:'delete',
                              context, Container(
                                height: 300,width: 300,
                                child: ValueListenableBuilder<UserState>(
                                  valueListenable: UserController.instance,
                                  builder: (context,state,child) {
                                  
                                    if(state is UserStateLoading){
                                     
                                      return CircularLoading();
                                    }
                                    return AlertDialog(title: Text('Deletar user, tem certeza ?'),);
                                  }
                                ),
                              ), onSave: () async {
                                  Navigator.of(context).pop();
                              UserState result =
                                  await UserController.instance.deleteUser(e);
                              if (result is UserStateSucess) {
                                return true;
                              }
                              return false;
                            });
                          
              },
              child: const Padding(
                padding: EdgeInsets.all(2),
                child: Icon(
                  Icons.delete,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: () {
                Navigator.pushNamed(context,'/ListReceiptsPage',arguments: e.id);
              },
              child: const Padding(
                padding: EdgeInsets.all(2),
                child: Icon(
                  Icons.receipt,
                  color: Colors.amber,
                ),
              ),
            )
          ]),
        ]
      )]));
   
    User user = User(nome: '', cnpj: '', password: '', isAtivo: 1, dtCriacao: DateTime.now(), dtAutalizacao: DateTime.now());
      if(state is UserStateLoading){
        return CircularLoading();
      }
       return Scaffold(
         body: SingleChildScrollView(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 TableUi(
                   title: 'Usuários',
                 isSelected: false,
                 extraLines: 0,
                 tableUiController: tableUiControllerRequiriments,
                 addCallBack: () {
                    DialogUtil().showDialogUtil(title:'Formulario Loja',context, EditUsers(user: user,),
                    onSave: (()async{ await UserController.instance.setUser(user); return true;}));
                 })
                ],
              ),
         ),
       );
     }
   ),
 );
  }
}
