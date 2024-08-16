import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Provider/LocationProvider.dart';

class LocationPermissionErrorDisplay extends StatelessWidget {
  const LocationPermissionErrorDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, weatherProv, _) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width,
                minWidth: 100,
                maxHeight: MediaQuery.sizeOf(context).height / 3,
              ),
              child: Image.asset("assets/images/locError.png"),
            ),
            const Center(
              child: Text(
                'Location Permission Error',
              ),
            ),
            const SizedBox(height: 4.0),
            Center(
              child: Text(
                weatherProv.locationPermission ==
                        LocationPermission.deniedForever
                    ? 'Location permissions are permanently denied, Please enable manually from app settings and restart the app'
                    : 'Location permission not granted, please check your location permission',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: weatherProv.isLoading
                        ? null
                        : () async {
                            if (weatherProv.locationPermission ==
                                LocationPermission.deniedForever) {
                              await Geolocator.openAppSettings();
                            } else {
                              weatherProv.requestLocation(context);
                            }
                          },
                    child: weatherProv.isLoading
                        ? const SizedBox(
                            width: 16.0,
                            height: 16.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            weatherProv.locationPermission ==
                                    LocationPermission.deniedForever
                                ? 'Open App Settings'
                                : 'Request Permission',
                          ),
                  ),
                  const SizedBox(height: 4.0),
                  if (weatherProv.locationPermission ==
                      LocationPermission.deniedForever)
                    TextButton(
                      onPressed: weatherProv.isLoading
                          ? null
                          : () => weatherProv.requestLocation(
                                context,
                              ),
                      child: const Text('Restart'),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
