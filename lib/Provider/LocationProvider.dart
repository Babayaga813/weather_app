import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Helpers/AppConstants/AppConstants.dart';
import 'package:weather_app/Provider/WeatherProvider.dart';
import 'package:weather_app/Services/GeoLocation/GeoLocation.dart';

class LocationProvider extends ChangeNotifier {
  bool isLoading = true;

  Placemark locationDetails = const Placemark();

  bool premissionGranted = false;
  bool locationFetched = false;
  bool isLocationserviceEnabled = false;
  LocationPermission? locationPermission;

  final GeoLocation location = GetIt.instance<GeoLocation>();
  Future<void> requestLocation(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    isLocationserviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationserviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location service disabled')),
      );
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        isLoading = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Permission denied'),
        ));
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Location permissions are permanently denied, Please enable manually from app settings',
        ),
      ));
    }

    var data = await Geolocator.getCurrentPosition();

    List<Placemark> list =
        await placemarkFromCoordinates(data.latitude, data.longitude);

    AppConstants.currentLocationDetails = list[0];

    locationDetails = list[0];

    await Provider.of<WeatherProvider>(context, listen: false)
        .getCurrentLocationsWeather(locationDetails.locality ?? "");
    isLoading = false;
    notifyListeners();
  }
}
