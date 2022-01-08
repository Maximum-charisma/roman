import 'package:flutter/material.dart';
import 'package:ridbrain_project/services/objects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPrefsHandler {
  AdminPrefsHandler(this._preferences);

  final SharedPreferences _preferences;

  final String _adminToken = "adminToken";
  final String _adminId = "adminId";
  final String _adminName = "adminName";
  final String _adminEmail = "adminEmail";
  final String _adminStatus = "adminStatus";
  final String _adminRole = "adminRole";

  static Future<AdminPrefsHandler> getInstance() async {
    var shared = await SharedPreferences.getInstance();
    return AdminPrefsHandler(shared);
  }

  String getAdminToken() {
    return _preferences.getString(_adminToken) ?? "";
  }

  void setAdminToken(String value) {
    _preferences.setString(_adminToken, value);
  }

  int getAdminId() {
    return _preferences.getInt(_adminId) ?? 0;
  }

  void setAdminId(int value) {
    _preferences.setInt(_adminId, value);
  }

  String getAdminName() {
    return _preferences.getString(_adminName) ?? "";
  }

  void setAdminName(String value) {
    _preferences.setString(_adminName, value);
  }

  String getAdminEmail() {
    return _preferences.getString(_adminEmail) ?? "";
  }

  void setAdminEmail(String value) {
    _preferences.setString(_adminEmail, value);
  }

  int getAdminStatus() {
    return _preferences.getInt(_adminStatus) ?? 0;
  }

  void setAdminStatus(int value) {
    _preferences.setInt(_adminStatus, value);
  }

  int getAdminRole() {
    return _preferences.getInt(_adminRole) ?? 0;
  }

  void setAdminRole(int value) {
    _preferences.setInt(_adminRole, value);
  }

  void setEmptyAdmin() {
    _preferences.setString(_adminToken, '');
  }
}

class DataProvider extends ChangeNotifier {
  DataProvider(
    this._admin,
  );

  User _admin;

  User get user => _admin;
  bool get hasAdmin => _admin.token != "";

  static Future<DataProvider> getInstance() async {
    var prefs = await AdminPrefsHandler.getInstance();
    return DataProvider(
      User(
        token: prefs.getAdminToken(),
        userId: prefs.getAdminId(),
        userName: prefs.getAdminName(),
        userEmail: prefs.getAdminEmail(),
        userStatus: prefs.getAdminStatus(),
        userRole: prefs.getAdminRole(),
      ),
    );
  }

  void setAdmin(User admin) {
    _admin = admin;
    notifyListeners();
    AdminPrefsHandler.getInstance().then(
      (value) {
        value.setAdminToken(admin.token!);
        value.setAdminName(admin.userName);
        value.setAdminId(admin.userId);
        value.setAdminEmail(admin.userEmail);
        value.setAdminStatus(admin.userStatus);
        value.setAdminRole(admin.userRole);
      },
    );
  }

  void setAdminToken(String newToken) {
    _admin.token = newToken;
    notifyListeners();
    AdminPrefsHandler.getInstance().then(
      (value) => value.setAdminToken(newToken),
    );
  }

  void setAdminName(String newName) {
    _admin.userName = newName;
    notifyListeners();
    AdminPrefsHandler.getInstance().then(
      (value) => value.setAdminName(newName),
    );
  }

  void setAdminEmail(String newEmail) {
    _admin.userEmail = newEmail;
    notifyListeners();
    AdminPrefsHandler.getInstance().then(
      (value) => value.setAdminEmail(newEmail),
    );
  }

  void signOut() {
    _admin = User(
        token: '',
        userId: 0,
        userName: '',
        userEmail: '',
        userStatus: 0,
        userRole: 0);
    notifyListeners();

    AdminPrefsHandler.getInstance().then((value) => value.setEmptyAdmin());
  }
}
