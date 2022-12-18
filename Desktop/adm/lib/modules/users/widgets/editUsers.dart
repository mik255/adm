import 'package:adm/mainStances.dart';
import 'package:adm/modules/storie/storie_controller/storie_controller.dart';
import 'package:adm/modules/storie/widgets/listProducts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../models/user.model.dart';
import '../../../shared/widgets/circurarLoading.dart';
import '../../../shared/widgets/customTextField.dart';
import '../../../shared/widgets/switchWithTitle.dart';
import '../store/store.dart';



class EditUsers extends StatelessWidget {
   EditUsers({Key? key,this.user}) : super(key: key);
   User? user;
  @override
  Widget build(BuildContext context) {
   user = user??User(nome: '', cnpj: '', password: '', isAtivo: 1, dtCriacao: DateTime.now(), dtAutalizacao: DateTime.now());
    return  ValueListenableBuilder<UserState>(
      valueListenable: UserController.instance,
      builder: (context, state,child) {
        if(state is UserStateSucess){
       return Container(
          width: 500,
          child: Column(children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            initialText: user?.nome,
                            title: 'nome do usuário',
                            onChange: (String value) {
                              user?.nome = value;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            initialText: user?.password,
                            title: 'Senha',
                            onChange: (String value) {
                               user?.password = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            initialText: user?.cnpj,
                            title: 'CNPJ',
                            onChange: (String value) {
                               user?.cnpj = value;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SwitchWithTitle(
                          title: "Atividade",
                          initialValue: true,
                          onChange: (v) {
                          user?.isAtivo = v?1:0;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ]),
        );
        }
        return CircularLoading();
      }
    
    );
  }
}
