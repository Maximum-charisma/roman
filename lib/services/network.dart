import 'package:flutter/material.dart';
import 'package:ridbrain_project/services/check_token.dart';
import 'package:http/http.dart' as http;
import 'package:ridbrain_project/services/constants.dart';
import 'package:ridbrain_project/services/objects.dart';
import 'package:ridbrain_project/services/snack_bar.dart';

class Network {
  Network(
    this.context,
  );

  final BuildContext context;

  static Future<String?> _request({
    required String url,
    Map<String, String>? params,
  }) async {
    var response = await http.post(
      Uri.parse(apiUrl + url),
      body: params,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  void _showAnswer(int status, String message) {
    StandartSnackBar.show(
      context,
      message,
      status == 0 ? SnackBarStatus.success() : SnackBarStatus.warning(),
    );
  }

  static Future<bool> checkToken(
    String token,
  ) async {
    var address = 'check_token.php';

    var data = await _request(url: address, params: {
      "token": token,
    });

    if (data != null) {
      var answer = checkTokenFromJson(data);
      if (answer.error == 0) {
        return answer.status == 1;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<DriverAnswer?> getDriver(
    String login,
    String pass,
  ) async {
    var address = 'user_auth.php';

    var data = await _request(url: address, params: {
      "login": login,
      "pass": pass,
    });

    if (data != null) {
      var answer = driverAnswerFromJson(data);
      return answer;
    } else {
      return null;
    }
  }

  static Future<List<Record>> getRecords(
    String token,
  ) async {
    var address = 'get_records.php';

    var data = await _request(url: address, params: {
      "token": token,
    });

    if (data != null) {
      var answer = recordsAnswerFromJson(data);

      return answer.records;
    } else {
      return [];
    }
  }

  static Future<List<Record>> getActiveRecords(
    String token,
  ) async {
    var address = 'get_active_records.php';

    var data = await _request(url: address, params: {
      "token": token,
    });

    if (data != null) {
      var answer = recordsAnswerFromJson(data);

      return answer.records;
    } else {
      return [];
    }
  }

  static Future<bool> changeRecordStatus(
    String token,
    String recordId,
    String recordStatus,
    String recordHistory,
  ) async {
    var address = 'change_record_status.php';

    var data = await _request(url: address, params: {
      "token": token,
      "record_id": recordId,
      "record_status": recordStatus,
      "record_history": recordHistory
    });

    if (data != null) {
      var answer = messageAnswerFromJson(data);

      return answer.error == 0;
    } else {
      return false;
    }
  }

  Future<bool> confirmRecord(
    String token,
    String recordId,
    String driver,
    String recordHistory,
  ) async {
    var address = 'confirm_record.php';

    var data = await _request(url: address, params: {
      "token": token,
      "record_id": recordId,
      "driver": driver,
      "record_history": recordHistory,
    });

    if (data != null) {
      var answer = messageAnswerFromJson(data);
      _showAnswer(answer.error, answer.message);

      return answer.error == 0;
    } else {
      return false;
    }
  }

  Future<bool> changePass(
    String token,
    String oldPass,
    String newPass,
  ) async {
    var address = 'change_pass.php';

    var data = await _request(url: address, params: {
      "token": token,
      "old_pass": oldPass,
      "new_pass": newPass,
    });

    if (data != null) {
      var answer = messageAnswerFromJson(data);
      _showAnswer(answer.error, answer.message);

      return answer.error == 0;
    } else {
      return false;
    }
  }

  static Future addCoordinates(
    String token,
    String driverId,
    String latitude,
    String longitude,
  ) async {
    var address = 'add_coordinate.php';

    await _request(url: address, params: {
      "token": token,
      "driver_id": driverId,
      "latitude": latitude,
      "longitude": longitude,
    });
  }
}
