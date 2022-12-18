// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String customToString() {
    DateFormat dateFormatterPtBr = DateFormat('dd/MM/yyyy');
    return dateFormatterPtBr.format(this);
  }
}


