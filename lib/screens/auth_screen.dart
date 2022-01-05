// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/services/app_bar.dart';
import 'package:ridbrain_project/services/buttons.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';
import 'package:ridbrain_project/services/snack_bar.dart';
import 'package:ridbrain_project/services/text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _loginController = TextEditingController();
  final _passController = TextEditingController();

  void _login() {
    if (_loginController.text.isNotEmpty && _passController.text.isNotEmpty) {
      Network.getDriver(_loginController.text, _passController.text).then(
        (answer) {
          if (answer?.error == 0) {
            Provider.of<DriverProvider>(context, listen: false)
                .setDriver(answer!.driver!);
          } else {
            StandartSnackBar.show(
              context,
              'Ошибка.',
              SnackBarStatus.warning(),
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          StandartAppBar(
            title: Text('Авторизация'),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Roman.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Delivery",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: TextFieldWidget(
                hint: 'E-Mail',
                controller: _loginController,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
              child: TextFieldWidget(
                hint: 'Пароль',
                controller: _passController,
                password: true,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandartButton(
              label: 'Войти',
              onTap: _login,
            ),
          ),
        ],
      ),
    );
  }
}
