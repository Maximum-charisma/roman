import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/objects.dart';

class Location {
  Location(
    this.driver,
  );

  final Driver driver;

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  void sendLocation() {
    determinePosition().then(
      (value) {
        Network.addCoordinates(
          driver.driverToken,
          driver.driverId.toString(),
          value.latitude.toString(),
          value.longitude.toString(),
        );
      },
    );

    Timer.periodic(
      const Duration(minutes: 5),
      (Timer t) {
        determinePosition().then(
          (value) {
            Network.addCoordinates(
              driver.driverToken,
              driver.driverId.toString(),
              value.latitude.toString(),
              value.longitude.toString(),
            );
          },
        );
      },
    );
  }
}
