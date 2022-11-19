import 'package:adm/shared/widgets/table/states.dart';
import 'package:flutter/material.dart';

import 'TableUiController.dart';

int selected = 0;

class TableUi extends StatelessWidget {
  TableUi({
    Key? key,
    required this.tableUiController,
    required this.extraLines,
    required this.isSelected,
    this.addCallBack,
    this.onSelect,
  }) : super(key: key);
  TableUiController tableUiController;
  int extraLines;
  Function()? addCallBack;
  Function(int index)? onSelect;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 1100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 156, 156, 156),
                                      offset: Offset(0.0, 0), //(x,y)
                                      blurRadius: 5.0,
                                    ),
                                  ]),
                              child: Row(
                                children: [
                                  ...tableUiController.value.headers.map((e) =>
                                      Expanded(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: ((e.value is Text)
                                                  ? Text(
                                                      (e.value as Text).data ??
                                                          '',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : e.value))))
                                ],
                              ),
                            ),
                            SizedBox(height: 16,),
                            ...tableUiController.value.tableDataList.map(
                              (e0) => Column(
                                children: [
                                  ValueListenableBuilder<TableUiState?>(
                                    valueListenable: tableUiController,
                                    builder: (ctx, state, child) => InkWell(
                                      onTap: () {
                                        if (isSelected) {
                                          selected = tableUiController
                                              .value.tableDataList
                                              .indexOf(e0);
                                          tableUiController.selectRow(
                                              e0, selected);
                                          onSelect?.call(selected);
                                        }
                                      },
                                      child: Container(
                                        color: isSelected == true &&
                                                selected ==
                                                    tableUiController
                                                        .value.tableDataList
                                                        .indexOf(e0)
                                            ? Colors.blue
                                            : Colors.white,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                ...e0.map((e) {
                                                  if (e is TableHeader) {
                                                    return Container(
                                                        color: Color.fromARGB(
                                                            255, 231, 231, 231),
                                                        child:
                                                            ((e.value is Text)
                                                                ? Text(
                                                                    (e.value as Text)
                                                                            .data ??
                                                                        '',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )
                                                                : e.value));
                                                  }
                                                  if (e is TableCellRow) {
                                                    return Expanded(
                                                        child: _cellText(e));
                                                  }
                                                  if (e is TableActions) {
                                                    return Expanded(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 16.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Spacer(),
                                                          ...?e.actions
                                                        ],
                                                      ),
                                                    ));
                                                  }
                                                  return const Text('--');
                                                }),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  color: Colors.grey.shade100,
                                                  height: 1,
                                                )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ...List.generate(
                                extraLines,
                                (index) => Column(
                                      children: [
                                        Container(
                                          height: 32,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              color: Colors.grey.shade100,
                                              height: 1,
                                            )),
                                          ],
                                        )
                                      ],
                                    ))
                          ],
                        ),
                        if (addCallBack != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 28,
                                  child: FloatingActionButton(
                                    backgroundColor: Colors.blue,
                                    onPressed: () {
                                      addCallBack!.call();
                                    },
                                    mini: true,
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cellText(TableCellRow e) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: e.value,
    );
  }
}
