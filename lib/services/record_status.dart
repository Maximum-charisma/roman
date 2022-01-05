import 'package:flutter/material.dart';

enum StatusRecord { one, two, three, four, five, six }

class RecordStatus {
  RecordStatus({
    required this.status,
    required this.date,
  });

  StatusRecord status;
  int date;

  String getLabel() {
    switch (status) {
      case StatusRecord.one:
        return "Ожидание";
      case StatusRecord.two:
        return "Принята";
      case StatusRecord.three:
        return "На загрузке";
      case StatusRecord.four:
        return "На выгрузке";
      case StatusRecord.five:
        return "Выполнена";
      case StatusRecord.six:
        return "Отменена";
    }
  }

  Color getColor() {
    switch (status) {
      case StatusRecord.one:
        return Colors.red.shade100;
      case StatusRecord.two:
        return Colors.orange.shade100;
      case StatusRecord.three:
        return Colors.blue.shade100;
      case StatusRecord.four:
        return Colors.teal.shade100;
      case StatusRecord.five:
        return Colors.green.shade100;
      case StatusRecord.six:
        return Colors.grey.shade100;
    }
  }

  static StatusRecord getStatusFromString(String statusString) {
    for (StatusRecord item in StatusRecord.values) {
      if (item.toString() == statusString) {
        return item;
      }
    }
    return StatusRecord.one;
  }

  factory RecordStatus.fromJson(Map<String, dynamic> json) => RecordStatus(
        status: getStatusFromString(json['status']),
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        "status": status.name,
        "date": date,
      };
}