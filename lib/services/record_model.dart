import 'package:flutter/material.dart';
import 'package:ridbrain_project/services/objects.dart';

class Record {
  Record({
    required this.recordId,
    required this.recordDate,
    required this.recordStatus,
    required this.recordNote,
    required this.company,
    required this.recordHistory,
    this.driver,
  });

  int recordId;
  int recordDate;
  StatusRecord recordStatus;
  String recordNote;
  Company company;
  Driver? driver;
  List<RecordStatus> recordHistory;

  String driverName() {
    if (driver == null) {
      return "Водитель не назначен";
    }
    return driver!.driverName;
  }

  Color getColor() {
    switch (recordStatus) {
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

  String getStatus() {
    switch (recordStatus) {
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

  static StatusRecord getStatusFromString(String statusString) {
    for (StatusRecord item in StatusRecord.values) {
      if (item.toString() == statusString) {
        return item;
      }
    }
    return StatusRecord.one;
  }

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        recordId: json["record_id"],
        recordDate: json["record_date"],
        recordHistory: List<RecordStatus>.from(
          json["record_history"].map((x) => RecordStatus.fromJson(x)),
        ),
        recordNote: json["record_note"],
        driver: json["driver"] != null ? Driver.fromJson(json["driver"]) : null,
        company: Company.fromJson(json["company"]),
        recordStatus: getStatusFromString(json['record_status']),
      );

  Map<String, dynamic> toJson() => {
        "record_id": recordId,
        "record_date": recordDate,
        "record_history": List<dynamic>.from(
          recordHistory.map((x) => x.toJson()),
        ),
        "record_note": recordNote,
        "driver": driver != null ? driver!.toJson() : "",
        "record_status": recordStatus.name,
        "company": company.toJson(),
      };
}
