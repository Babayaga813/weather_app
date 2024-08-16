// import 'package:geocoding/geocoding.dart';
// import 'package:location/location.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/Helpers/ServiceResult/ServiceResult.dart';

class GeoLocation {
  Future<bool> getLocationServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<LocationPermission> getLocationPermission() async {
    try {
      var permission = await Geolocator.checkPermission();
      return permission;
    } catch (e) {
      debugPrint(e.toString());
      return LocationPermission.unableToDetermine;
    }
  }

  Future<ServiceResult<LocationPermission>> requestLocationPermission() async {
    try {
      var permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return ServiceResult(
            statusCode: StatusCode.ok,
            data: permission,
            message: "Access granted");
      } else {
        return ServiceResult(
            statusCode: StatusCode.forbidden,
            data: permission,
            message: "Access not given");
      }
    } catch (e) {
      debugPrint(e.toString());
      return ServiceResult(
          statusCode: StatusCode.forbidden,
          data: LocationPermission.unableToDetermine,
          message: "Access not given");
    }
  }

  Future<ServiceResult<Placemark>> getLocationDetails() async {
    try {
      Position locationData = await Geolocator.getCurrentPosition();
      List<Placemark> list = await placemarkFromCoordinates(
          locationData.latitude, locationData.longitude);
      if (list.isNotEmpty) {
        return ServiceResult(
            statusCode: StatusCode.ok,
            data: list.first,
            message: "Successfully fetched location");
      } else {
        return ServiceResult(
            statusCode: StatusCode.noContent,
            data: const Placemark(),
            message: "unable to fetch location details");
      }
    } catch (e) {
      debugPrint(e.toString());
      return ServiceResult(
          statusCode: StatusCode.forbidden,
          data: const Placemark(),
          message: "unable to fetch location details");
    }
  }

  // Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   Position data = await Geolocator.getCurrentPosition();
  //   List<Placemark> list =
  //       await placemarkFromCoordinates(data.latitude, data.longitude);
  //   print(list[0].locality);
  //   return await Geolocator.getCurrentPosition();
  // }
}
