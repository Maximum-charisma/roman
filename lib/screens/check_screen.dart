import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/admin_screen.dart';
import 'package:ridbrain_project/screens/auth_screen.dart';
import 'package:ridbrain_project/screens/main_screen.dart';
import 'package:ridbrain_project/services/admin_provider.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';

class CheckToken extends StatelessWidget {
  const CheckToken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var driverProvider = Provider.of<DriverProvider>(context);
    var adminProvider = Provider.of<DataProvider>(context);

    return Scaffold(body: futureBulder(driverProvider, adminProvider, context));
  }

  Widget? futureBulder(DriverProvider driverProvider,
      DataProvider adminProvider, BuildContext context) {
    if (driverProvider.hasDriver) {
      return FutureBuilder(
        future: Network.checkDriverToken(driverProvider.driver.driverToken),
        builder: (context, AsyncSnapshot<bool> snap) {
          if (snap.hasData) {
            if (snap.data ?? false) {
              return MainScreen();
            } else {
              return const AuthScreen();
            }
          }
          return const Center(child: CupertinoActivityIndicator());
        },
      );
    } else if (adminProvider.hasAdmin) {
      return FutureBuilder(
        future: Network(context).checkAdminToken(adminProvider.user.token!),
        builder: (context, AsyncSnapshot<bool> snap) {
          if (snap.hasData) {
            if (snap.data ?? false) {
              return AdminScreen();
            } else {
              return const AuthScreen();
            }
          }
          return const Center(child: CupertinoActivityIndicator());
        },
      );
    } else {
      return const AuthScreen();
    }
  }
}
