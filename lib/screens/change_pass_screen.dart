import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/services/app_bar.dart';
import 'package:ridbrain_project/services/buttons.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';
import 'package:ridbrain_project/services/snack_bar.dart';
import 'package:ridbrain_project/services/text_field.dart';

class PassScreen extends StatefulWidget {
  PassScreen({Key? key}) : super(key: key);

  @override
  _PassScreenState createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  TextEditingController _oldPass = TextEditingController();
  TextEditingController _newPass = TextEditingController();
  TextEditingController _secondNewPass = TextEditingController();

  Future<void> _checkFields(provider) async {
    if (_oldPass.text.isNotEmpty &&
        _newPass.text.isNotEmpty &&
        _secondNewPass.text.isNotEmpty) {
      if (_newPass.text == _secondNewPass.text) {
        await Network(context).changePass(
          provider.driver.driverToken,
          _oldPass.text,
          _newPass.text,
        );
      } else {
        StandartSnackBar.show(
          context,
          'Новые пароли не совпадают.',
          SnackBarStatus.warning(),
        );
      }
    } else {
      StandartSnackBar.show(
        context,
        'Поля не заполнены.',
        SnackBarStatus.warning(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DriverProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          StandartAppBar(
            title: Text('Смена пароля'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: TextFieldWidget(
                hint: 'Старый пароль',
                controller: _oldPass,
                password: true,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: TextFieldWidget(
                hint: 'Новый пароль',
                controller: _newPass,
                password: true,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
              child: TextFieldWidget(
                hint: 'Новый пароль',
                controller: _secondNewPass,
                password: true,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandartButton(
              label: 'Изменить пароль',
              onTap: () => _checkFields(provider),
            ),
          ),
        ],
      ),
    );
  }
}
