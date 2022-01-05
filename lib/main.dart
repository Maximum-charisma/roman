import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/check_screen.dart';
import 'package:ridbrain_project/services/position.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var driverProvider = await DriverProvider.getInstance();
  Location.determinePosition();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => driverProvider,
        ),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.grey),
          debugShowCheckedModeBanner: false,
          home: const CheckToken(),
        ),
      ),
    ),
  );
}
