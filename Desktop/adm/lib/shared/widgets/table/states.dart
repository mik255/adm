import 'TableUiController.dart';

class TableUiState{
  TableUiState({
    required this.tableDataList,
    required this.headers,
    this.dataTextSelected
  });
  List<TableHeader> headers;
  List<List<TableData>> tableDataList;
  List<TableData>? dataTextSelected;
}