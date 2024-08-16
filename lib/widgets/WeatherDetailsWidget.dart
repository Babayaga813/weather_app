import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/Helpers/AppConstants/AppConstants.dart';
import 'package:weather_app/Helpers/Navigation/AppRouteConstants.dart';
import 'package:weather_app/widgets/CurrentWeatherWidget.dart';
import 'package:weather_app/widgets/CustomButton.dart';
import 'package:weather_app/widgets/FiveDaysWeatherDetails.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherDetailsWidget extends StatefulWidget {
  const WeatherDetailsWidget({super.key});

  @override
  State<WeatherDetailsWidget> createState() => _WeatherDetailsWidgetState();
}

class _WeatherDetailsWidgetState extends State<WeatherDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => GoRouter.of(context)
                  .pushNamed(AppRouteConstants.settingsRoute),
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          20.verticalSpace,
          CurrentWeatherWidget(
              todayWeatherData: AppConstants.todayWeatherData.first,
              locality: AppConstants.currentLocationDetails?.locality ?? ""),
          20.verticalSpace,
          FiveDaysWeatherDetails(
            weatherDataList: AppConstants.fiveDaysWeatherData,
          ),
          30.verticalSpace,
          CustomButton(
              buttonColor: const Color(0xFFBDD6FF),
              onTap: () =>
                  GoRouter.of(context).pushNamed(AppRouteConstants.newsRoute),
              label: "Get News",
              icon: Icons.newspaper)
        ],
      ),
    );
  }
}
