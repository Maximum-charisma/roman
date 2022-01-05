import 'dart:convert';

CheckToken checkTokenFromJson(String str) => CheckToken.fromJson(json.decode(str));

String checkTokenToJson(CheckToken data) => json.encode(data.toJson());

class CheckToken {
    CheckToken({
        required this.error,
        required this.status,
    });

    int error;
    int status;

    factory CheckToken.fromJson(Map<String, dynamic> json) => CheckToken(
        error: json["error"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "status": status,
    };
}
