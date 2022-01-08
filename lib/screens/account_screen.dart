import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/change_pass_screen.dart';
import 'package:ridbrain_project/screens/policy_screen.dart';
import 'package:ridbrain_project/services/app_bar.dart';
import 'package:ridbrain_project/services/constants.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DriverProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          StandartAppBar(
            title: Text("Настройки"),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      LineIcons.userCircle,
                      size: 60,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.driver.driverName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          provider.driver.driverEmail,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.all(15),
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              decoration: const BoxDecoration(
                borderRadius: radius,
              ),
              child: Material(
                borderRadius: radius,
                color: Colors.grey[200],
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PassScreen(),
                    ),
                  ),
                  borderRadius: radius,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(LineIcons.key),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Изменить пароль',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              decoration: const BoxDecoration(
                borderRadius: radius,
              ),
              child: Material(
                borderRadius: radius,
                color: Colors.grey[200],
                child: InkWell(
                  onTap: () => provider.signOut(),
                  borderRadius: radius,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(LineIcons.alternateSignOut),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Выйти',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              decoration: const BoxDecoration(
                borderRadius: radius,
              ),
              child: Material(
                borderRadius: radius,
                color: Colors.grey[200],
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // fullscreenDialog: true,
                        builder: (context) => PolicyScreen(),
                      ),
                    );
                  },
                  borderRadius: radius,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(LineIcons.info),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Политика и кофиденциальность',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
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
    );
  }
}
