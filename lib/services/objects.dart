import 'dart:convert';

import 'package:flutter/material.dart';

AuthAnswer authAnswerFromJson(String str) =>
    AuthAnswer.fromJson(json.decode(str));

class AuthAnswer {
  AuthAnswer({
    required this.error,
    required this.message,
    required this.token,
  });

  int error;
  String message;
  String token;

  factory AuthAnswer.fromJson(Map<String, dynamic> json) => AuthAnswer(
        error: json["error"] ?? 1,
        message: json["message"] ?? "",
        token: json["token"] ?? "",
      );
}

TokenAnswer tokenAnswerFromJson(String str) =>
    TokenAnswer.fromJson(json.decode(str));

class TokenAnswer {
  TokenAnswer({
    required this.error,
    required this.status,
  });

  int error;
  int status;

  factory TokenAnswer.fromJson(Map<String, dynamic> json) => TokenAnswer(
        error: json["error"] ?? 1,
        status: json["status"] ?? 0,
      );
}

CompaniesAnswer companiesAnswerFromJson(String str) =>
    CompaniesAnswer.fromJson(json.decode(str));

class CompaniesAnswer {
  CompaniesAnswer({
    required this.error,
    required this.companies,
  });

  int error;
  List<Company> companies;

  factory CompaniesAnswer.fromJson(Map<String, dynamic> json) =>
      CompaniesAnswer(
        error: json["error"],
        companies: List<Company>.from(
          json["companies"].map((x) => Company.fromJson(x)),
        ),
      );
}

CompanyAnswer companyAnswerFromJson(String str) =>
    CompanyAnswer.fromJson(json.decode(str));

class CompanyAnswer {
  CompanyAnswer({
    required this.error,
    required this.company,
  });

  int error;
  Company company;

  factory CompanyAnswer.fromJson(Map<String, dynamic> json) => CompanyAnswer(
        error: json["error"],
        company: Company.fromJson(json['company']),
      );
}

class Company {
  Company({
    required this.companyId,
    required this.companyName,
    required this.companyPhone,
    required this.companyLocation,
    required this.companyNote,
    required this.companyWeb,
  });

  int companyId;
  String companyName;
  CompanyLocation companyLocation;
  String companyPhone;
  String companyNote;
  String companyWeb;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        companyId: json["company_id"] ?? 0,
        companyName: json["company_name"] ?? "",
        companyPhone: json["company_phone"].toString(),
        companyLocation: CompanyLocation.fromJson(json['company_location']),
        companyNote: json["company_note"] ?? "",
        companyWeb: json["company_web"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "company_name": companyName.replaceAll('"', '\\"'),
        "company_phone": companyPhone,
        "company_location": companyLocation,
        "company_note": companyNote,
        "company_web": companyWeb,
      };
}

class CompanyLocation {
  CompanyLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  String address;
  double latitude;
  double longitude;

  factory CompanyLocation.fromJson(Map<String, dynamic> json) =>
      CompanyLocation(
        address: json["address"] ?? "",
        latitude: json["latitude"].toDouble() ?? 0,
        longitude: json["longitude"].toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}

RecordsAnswer recordsAnswerFromJson(String str) =>
    RecordsAnswer.fromJson(json.decode(str));

class RecordsAnswer {
  RecordsAnswer({
    required this.error,
    required this.records,
  });

  int error;
  List<Record> records;

  factory RecordsAnswer.fromJson(Map<String, dynamic> json) => RecordsAnswer(
        error: json["error"],
        records: List<Record>.from(
          json["records"].map((x) => Record.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "records": List<dynamic>.from(
          records.map((x) => x.toJson()),
        ),
      };
}

RecordAnswer recordAnswerFromJson(String str) =>
    RecordAnswer.fromJson(json.decode(str));

class RecordAnswer {
  RecordAnswer({
    required this.error,
    required this.record,
  });

  int error;
  Record record;

  factory RecordAnswer.fromJson(Map<String, dynamic> json) => RecordAnswer(
        error: json["error"],
        record: Record.fromJson(json["record"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "record": record.toJson(),
      };
}

Record recordFromJson(String str) => Record.fromJson(json.decode(str));

String recordToJson(Record data) => json.encode(data.toJson());

class Record {
  Record({
    required this.recordId,
    required this.recordDate,
    required this.recordStatus,
    required this.recordNote,
    required this.company,
    required this.recordHistory,
  });

  int recordId;
  int recordDate;
  StatusRecord recordStatus;
  String recordNote;
  Company company;
  List<RecordStatus> recordHistory;

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
      if (item.name == statusString) {
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
        "record_status": recordStatus.name,
        "company": company.toJson(),
      };
}

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
      if (item.name == statusString) {
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

DriversAnswer driversAnswerFromJson(String str) =>
    DriversAnswer.fromJson(json.decode(str));

String driversAnswerToJson(DriversAnswer data) => json.encode(data.toJson());

class DriversAnswer {
  DriversAnswer({
    required this.error,
    required this.drivers,
  });

  int error;
  List<Driver> drivers;

  factory DriversAnswer.fromJson(Map<String, dynamic> json) => DriversAnswer(
        error: json["error"] ?? 1,
        drivers: List<Driver>.from(
          json["drivers"].map((x) => Driver.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "drivers": List<dynamic>.from(drivers.map((x) => x.toJson())),
      };
}

DriverAnswer driverAnswerFromJson(String str) =>
    DriverAnswer.fromJson(json.decode(str));

class DriverAnswer {
  DriverAnswer({
    required this.error,
    required this.driver,
    required this.message,
  });

  int error;
  Driver? driver;
  String message;

  factory DriverAnswer.fromJson(Map<String, dynamic> json) => DriverAnswer(
        error: json["error"],
        driver: json["driver"] != null ? Driver.fromJson(json["driver"]) : null,
        message: json["message"] ?? '',
      );
}

Driver getDriverFromJson(String str) => Driver.fromJson(json.decode(str));

String getDriverToJson(Driver data) => json.encode(data.toJson());

class Driver {
  Driver({
    required this.driverToken,
    required this.driverName,
    required this.driverPhone,
    required this.driverEmail,
    required this.driverId,
    required this.driverStatus,
    required this.driverRecordCount,
  });

  String driverToken;
  String driverName;
  String driverPhone;
  String driverEmail;
  int driverId;
  int driverStatus;
  int driverRecordCount;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driverToken: json["driver_token"],
        driverName: json["driver_name"],
        driverId: json["driver_id"],
        driverPhone: json["driver_phone"],
        driverEmail: json["driver_email"],
        driverStatus: json["driver_status"],
        driverRecordCount: json["driver_record_count"],
      );

  Map<String, dynamic> toJson() => {
        "driver_name": driverName,
        "driver_phone": driverPhone,
        "driver_email": driverEmail,
        "driver_status": driverStatus,
        "driver_id": driverId,
        "driver_record_count": driverRecordCount,
      };
}

UsersAnswer usersAnswerFromJson(String str) =>
    UsersAnswer.fromJson(json.decode(str));

class UsersAnswer {
  UsersAnswer({
    required this.error,
    required this.users,
  });

  int error;
  List<User> users;

  factory UsersAnswer.fromJson(Map<String, dynamic> json) => UsersAnswer(
        error: json["error"],
        users: List<User>.from(
          json["users"].map((x) => User.fromJson(x)),
        ),
      );
}

UserAnswer userAnswerFromJson(String str) =>
    UserAnswer.fromJson(json.decode(str));

class UserAnswer {
  UserAnswer({
    required this.error,
    required this.user,
  });

  int error;
  User user;

  factory UserAnswer.fromJson(Map<String, dynamic> json) => UserAnswer(
        error: json["error"],
        user: User.fromJson(json['user']),
      );
}

class User {
  User({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userStatus,
    required this.userRole,
  });

  int userId;
  String userName;
  String userEmail;
  int userStatus;
  int userRole;

  String getStatus() {
    if (userStatus == 1) {
      return "Активный";
    } else {
      return "Отключён";
    }
  }

  String getRole() {
    switch (userRole) {
      default:
        return "Администратор";
    }
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userStatus: json["user_status"],
        userRole: json["user_role"],
      );
}

LocationsAnswer locationsAnswerFromJson(String str) =>
    LocationsAnswer.fromJson(json.decode(str));

class LocationsAnswer {
  LocationsAnswer({
    required this.error,
    required this.locations,
  });

  int error;
  List<Location> locations;

  factory LocationsAnswer.fromJson(Map<String, dynamic> json) =>
      LocationsAnswer(
        error: json["error"],
        locations: List<Location>.from(
          json["locations"].map((x) => Location.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "locations": List<dynamic>.from(
          locations.map((x) => x.toJson()),
        ),
      };
}

class Location {
  Location({
    required this.markId,
    required this.markDate,
    required this.latitude,
    required this.longitude,
  });

  int markId;
  int markDate;
  double latitude;
  double longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        markId: json["mark_id"],
        markDate: json["mark_date"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "mark_id": markId,
        "mark_date": markDate,
        "latitude": latitude,
        "longitude": longitude,
      };
}

PlacesAnswer placesAnswerFromJson(String str) =>
    PlacesAnswer.fromJson(json.decode(str));

class PlacesAnswer {
  PlacesAnswer({
    required this.results,
    required this.status,
  });

  List<Result> results;
  String status;

  factory PlacesAnswer.fromJson(Map<String, dynamic> json) => PlacesAnswer(
        results: List<Result>.from(
          json["results"].map((x) => Result.fromJson(x)),
        ),
        status: json["status"],
      );
}

class Result {
  Result({
    required this.formattedAddress,
    required this.geometry,
  });

  String formattedAddress;
  Geometry geometry;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromJson(json["geometry"]),
      );
}

class Geometry {
  Geometry({
    required this.location,
  });

  GoogleLocation location;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: GoogleLocation.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
      };
}

class GoogleLocation {
  GoogleLocation({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory GoogleLocation.fromJson(Map<String, dynamic> json) => GoogleLocation(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

MessageAnswer messageAnswerFromJson(String str) =>
    MessageAnswer.fromJson(json.decode(str));

class MessageAnswer {
  MessageAnswer({
    required this.error,
    required this.message,
  });

  int error;
  String message;

  factory MessageAnswer.fromJson(Map<String, dynamic> json) => MessageAnswer(
        error: json["error"] ?? 1,
        message: json["message"] ?? "",
      );
}
