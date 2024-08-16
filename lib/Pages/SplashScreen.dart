import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Provider/LocationProvider.dart';
import 'package:weather_app/Services/NewsAPI/NewsAPI.dart';
import 'package:weather_app/widgets/CustomLoadingWidget.dart';
import 'package:weather_app/widgets/WeatherDetailsWidget.dart';
import '../widgets/LocationPermissionErrorDisplay.dart';
import '../widgets/LocationServiceErrorDisplay.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NewsAPI api = NewsAPI();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getLocation();
    });
  }

  Future<void> _getLocation() async {
    await Provider.of<LocationProvider>(context, listen: false)
        .requestLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocationProvider>(builder: (context, locationProvider, _) {
        if (locationProvider.isLoading) {
          return const Center(child: CustomLoadingWidget());
        } else {
          if (!locationProvider.isLoading &&
              !locationProvider.isLocationserviceEnabled) {
            return const LocationServiceErrorDisplay();
          }
          if (!locationProvider.isLoading &&
              locationProvider.locationPermission !=
                  LocationPermission.always &&
              locationProvider.locationPermission !=
                  LocationPermission.whileInUse) {
            return const LocationPermissionErrorDisplay();
          }
          if (!locationProvider.isLoading) {
            return const WeatherDetailsWidget();
          }
        }
        return const Text("Fetching weather data");
      }),
    );
  }
}
