import 'package:location/location.dart';

class LocationUtilty {
  Future<LocationData?> getLocation() async {
    Location location = Location();

    await Future.delayed(const Duration(seconds: 2));

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw LocationServiceDisabledException();
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw PermissionDeniedException();
      }
    }

    return await location.getLocation();
  }
}

class LocationServiceDisabledException implements Exception {
  final String message;

  LocationServiceDisabledException(
      [this.message = "Location service is disabled."]);

  @override
  String toString() => "LocationServiceDisabledException: $message";
}

class PermissionDeniedException implements Exception {
  final String message;

  PermissionDeniedException([this.message = "Location permission denied."]);

  @override
  String toString() => "PermissionDeniedException: $message";
}
