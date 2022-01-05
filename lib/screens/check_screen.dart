import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/auth_screen.dart';
import 'package:ridbrain_project/screens/main_screen.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';

class CheckToken extends StatelessWidget {
  const CheckToken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DriverProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: Network.checkToken(provider.driver.driverToken),
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
      ),
    );
  }
}
