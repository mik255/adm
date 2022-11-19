
import 'package:adm/shared/widgets/table/states.dart';
import 'package:flutter/material.dart';

class TableData {
  TableData({this.isHeader = false});

  bool isHeader;
}

class TableHeader extends TableData {
  TableHeader({required this.value});

  Widget value;
}

class TableCellRow extends TableData {
  TableCellRow({
    required this.value,
  });

  Widget value;
}

class TableActions extends TableData {
  TableActions({this.actions});

  List<Widget>? actions;
}

class TableUiController extends ValueNotifier<TableUiState> {
  TableUiController(super.value);
  int indexSelected =0;
  selectRow(List<TableData> e,int index) {
    indexSelected = index;
    value = TableUiState(
        headers: value.headers,
        tableDataList: value.tableDataList,
        dataTextSelected: e
    );
    selectCallBack(e);
  }

  selectCallBack(List<TableData> e) {
    return e;
  }
}
