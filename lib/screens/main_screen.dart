import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/accept_orders_screen.dart';
import 'package:ridbrain_project/screens/account_screen.dart';
import 'package:ridbrain_project/screens/new_orders_screen.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';
import 'package:ridbrain_project/services/tab_item.dart';

import '../services/position.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

final List<TabItem> _tabBar = [
  TabItem(title: 'Новые заявки', icon: const Icon(LineIcons.calendar)),
  TabItem(title: 'Принятые заявки', icon: const Icon(LineIcons.checkSquare)),
  TabItem(title: 'Профиль', icon: const Icon(LineIcons.userCircle)),
];

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  var _first = true;
  late Location _location;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabBar.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DriverProvider>(context);

    if (_first) {
      _location = Location(provider.driver);
      _location.sendLocation();
      _first = false;
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _tabController.index = index;
            _currentTabIndex = index;
          });
        },
        currentIndex: _currentTabIndex,
        items: [
          for (final item in _tabBar)
            BottomNavigationBarItem(
              icon: item.icon,
              label: item.title,
            ),
        ],
      ),
      backgroundColor: Colors.white,
      body: TabBarView(controller: _tabController, children: const [
        NewOrdersScreen(),
        AcceptOrdersScreen(),
        AccountScreen(),
      ]),
    );
  }
}
