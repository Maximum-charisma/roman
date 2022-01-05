import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ConvertDate {
  ConvertDate(
    this.context,
  ) {
    initializeDateFormatting();
  }

  final BuildContext context;

  static DateTime dayBegin() {
    var date = DateTime.now().toLocal();
    return date.add(
      Duration(
        hours: -date.hour,
        minutes: -date.minute,
        seconds: -date.second,
        milliseconds: -date.millisecond,
        microseconds: -date.microsecond,
      ),
    );
  }

  static DateTime firstDayOfWeak() {
    var _today = DateTime.now().toLocal();
    return _today.add(
      Duration(
        days: -_today.weekday + 1,
        hours: -_today.hour,
        minutes: -_today.minute,
        seconds: -_today.second,
        milliseconds: -_today.millisecond,
      ),
    );
  }

  int fromDateTime(DateTime date) {
    return date.millisecondsSinceEpoch ~/ 1000;
  }

  String fromDate(DateTime date, String format) {
    Localizations.localeOf(context).languageCode;
    final DateFormat formatter = DateFormat(format, "ru");
    return formatter.format(date);
  }

  String fromUnix(int unix, String format) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(
      unix * 1000,
    ).toLocal();
    Localizations.localeOf(context).languageCode;
    final DateFormat formatter = DateFormat(format, "ru");
    return formatter.format(date);
  }
}
