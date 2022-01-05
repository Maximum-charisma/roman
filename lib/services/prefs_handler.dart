import 'package:flutter/material.dart';
import 'package:ridbrain_project/services/objects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHandler {
  PrefsHandler(this._preferences);

  final SharedPreferences _preferences;

  final String _driverId = "driverId";
  final String _driverName = "driverName";
  final String _driverEmail = "driverEmail";
  final String _driverPass = "driverPass";
  final String _driverStatus = "driverStatus";
  final String _driverPhone = "driverPhone";
  final String _driverRecordCount = "driverRecordCount";
  final String _driverToken = "driverToken";

  static Future<PrefsHandler> getInstance() async {
    var shared = await SharedPreferences.getInstance();
    return PrefsHandler(shared);
  }

  int getDriverId() {
    return _preferences.getInt(_driverId) ?? 0;
  }

  void setDriverUid(int value) {
    _preferences.setInt(_driverId, value);
  }

  String getDriverName() {
    return _preferences.getString(_driverName) ?? "";
  }

  void setDriverName(String value) {
    _preferences.setString(_driverName, value);
  }

  String getDriverEmail() {
    return _preferences.getString(_driverEmail) ?? "";
  }

  void setDriverEmail(String value) {
    _preferences.setString(_driverEmail, value);
  }

  String getDriverPass() {
    return _preferences.getString(_driverPass) ?? "";
  }

  void setDriverPass(String value) {
    _preferences.setString(_driverPass, value);
  }

  String getDriverPhone() {
    return _preferences.getString(_driverPhone) ?? "";
  }

  void setDriverPhone(String value) {
    _preferences.setString(_driverPhone, value);
  }

  int getDriverStatus() {
    return _preferences.getInt(_driverStatus) ?? 0;
  }

  void setDriverStatus(int value) {
    _preferences.setInt(_driverStatus, value);
  }

  int getDriverRecordCount() {
    return _preferences.getInt(_driverRecordCount) ?? 0;
  }

  void setDriverRecordCount(int value) {
    _preferences.setInt(_driverRecordCount, value);
  }

  String getDriverToken() {
    return _preferences.getString(_driverToken) ?? "";
  }

  void setDriverToken(String value) {
    _preferences.setString(_driverToken, value);
  }

  void setEmptyDriver() {
    _preferences.setInt(_driverId, 0);
    _preferences.setString(_driverName, '');
    _preferences.setString(_driverEmail, '');
    _preferences.setString(_driverPass, '');
    _preferences.setString(_driverPhone, '');
    _preferences.setInt(_driverStatus, 0);
    _preferences.setInt(_driverRecordCount, 0);
    _preferences.setString(_driverToken, '');
  }
}

class DriverProvider extends ChangeNotifier {
  DriverProvider(
    this._driver,
  );

  Driver _driver;

  Driver get driver => _driver;
  bool get hasDriver => _driver.driverToken != "";

  static Future<DriverProvider> getInstance() async {
    var prefs = await PrefsHandler.getInstance();
    return DriverProvider(Driver(
      driverName: prefs.getDriverName(),
      driverPhone: prefs.getDriverPhone(),
      driverEmail: prefs.getDriverEmail(),
      driverToken: prefs.getDriverToken(),
      driverId: prefs.getDriverId(),
      driverRecordCount: prefs.getDriverRecordCount(),
      driverStatus: prefs.getDriverStatus(),
    ));
  }

  void setDriver(Driver driver) {
    _driver = driver;
    notifyListeners();
    PrefsHandler.getInstance().then((value) {
      value.setDriverToken(driver.driverToken);
      value.setDriverName(driver.driverName);
      value.setDriverUid(driver.driverId);
      value.setDriverPhone(driver.driverPhone);
      value.setDriverEmail(driver.driverEmail);
      value.setDriverStatus(driver.driverStatus);
      value.setDriverRecordCount(driver.driverRecordCount);
    });
  }

  void setDriverToken(String newToken) {
    _driver.driverToken = newToken;
    notifyListeners();
    PrefsHandler.getInstance().then(
      (value) => value.setDriverToken(newToken),
    );
  }

  void setDriverName(String newName) {
    _driver.driverName = newName;
    notifyListeners();
    PrefsHandler.getInstance().then(
      (value) => value.setDriverName(newName),
    );
  }

  void setDriverPhone(String newPhone) {
    _driver.driverPhone = newPhone;
    notifyListeners();
    PrefsHandler.getInstance().then(
      (value) => value.setDriverPhone(newPhone),
    );
  }

  void setDriverEmail(String emailPhone) {
    _driver.driverPhone = emailPhone;
    notifyListeners();
    PrefsHandler.getInstance().then(
      (value) => value.setDriverEmail(emailPhone),
    );
  }

  void signOut() {
    _driver = Driver(
        driverToken: '',
        driverName: '',
        driverPhone: '',
        driverEmail: '',
        driverId: 0,
        driverStatus: 0,
        driverRecordCount: 0);
    notifyListeners();

    PrefsHandler.getInstance().then((value) => value.setEmptyDriver());
  }
}
