import 'package:adm/models/receipt.dart';
import 'package:adm/shared/widgets/GenericError.dart';
import 'package:adm/shared/widgets/circurarLoading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../storie/receipts_storie.dart';
import '../widgets/receipt_card.dart';

class ListReceiptsPage extends StatelessWidget {
  ListReceiptsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      body: ValueListenableBuilder<ReceiptState>(
          valueListenable: ReceiptController.instance..getByUserId(id),
          builder: (context, state, child) {
            if (state is ReceiptStateLoading) {
              return CircularLoading();
            }
            if (state is ReceiptStateError) {
              return GenericError(
                  title: 'Erro ao carregar recibos',
                  subtitle: state.msg,
                  errorCode: 'receiptsGenericError');
            }

            if (state is ReceiptStateSucess) {
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StatefulBuilder(builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        return ExpansionPanelList(
                            expansionCallback: (int index, bool isExpanded) {
                              setState(() {
                                state.currentUserReceipts![index].isExpanded =
                                    !isExpanded;
                              });
                            },
                            children: [
                              ...state.currentUserReceipts!
                                  .map<ExpansionPanel>((Receipt item) {
                                return ExpansionPanel(
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return Text(
                                        item.dt_criacao!.toIso8601String());
                                  },
                                  body: Column(children: [
                                       ...item.attributes.stories.map((e) =>  Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: ReceiptCard(story: e,),
                                       ))
                                  ],),
                                  isExpanded: item.isExpanded,
                                );
                              }).toList(),
                            ]);
                      })
                    ],
                  ),
                ),
              );
            }
            return const GenericError(
                title: 'Erro ao carregar recibos',
                subtitle: 'state não mapeado',
                errorCode: 'receiptsGenericError');
          }),
    );
  }
}
