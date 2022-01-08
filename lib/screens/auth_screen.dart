// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/policy_screen.dart';
import 'package:ridbrain_project/services/admin_provider.dart';
import 'package:ridbrain_project/services/app_bar.dart';
import 'package:ridbrain_project/services/buttons.dart';
import 'package:ridbrain_project/services/constants.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/objects.dart';
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
  int whichLogIn = 0;

  void _login() async {
    if (_loginController.text.isNotEmpty && _passController.text.isNotEmpty) {
      if (whichLogIn == 0) {
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
      } else {
        var result = await Network(context).userAuth(
          _loginController.text,
          _passController.text,
        );

        Provider.of<DataProvider>(context, listen: false).setAdmin(User(
            token: result.token,
            userId: result.user.userId,
            userEmail: result.user.userEmail,
            userName: result.user.userName,
            userRole: result.user.userRole,
            userStatus: result.user.userStatus));
      }
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
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Roman.",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Driver',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.fromLTRB(15, 0, 5, 15),
                          child: Material(
                            borderRadius: radius,
                            color: whichLogIn == 1
                                ? Colors.grey[100]
                                : Colors.grey[300],
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  whichLogIn = 0;
                                });
                              },
                              borderRadius: radius,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(LineIcons.car),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Водитель',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.fromLTRB(5, 0, 15, 15),
                          child: Material(
                            borderRadius: radius,
                            color: whichLogIn == 0
                                ? Colors.grey[100]
                                : Colors.grey[300],
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  whichLogIn = 1;
                                });
                              },
                              borderRadius: radius,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      LineIcons.user,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Администратор',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
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
            child: StandartButton(label: 'Войти', onTap: _login),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => PolicyScreen(),
                  ),
                );
              },
              child: Center(
                  child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text('Политика и конфиденциальность.'))),
            ),
          ),
        ],
      ),
    );
  }

  Color? adminOrDelivery() {
    switch (whichLogIn) {
      case 0:
        return Colors.grey[200];
      case 1:
        return Colors.grey[100];
    }
    return Colors.grey[100];
  }
}
