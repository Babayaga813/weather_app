import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/BOs/WeatherData.dart';
import 'package:weather_app/Helpers/Utilities/utilities.dart';
import 'package:weather_app/Provider/TemperatureProvider.dart';
import '../Helpers/AppConstants/AppConstants.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final DateWeather todayWeatherData;
  final String locality;

  const CurrentWeatherWidget({
    super.key,
    required this.todayWeatherData,
    required this.locality,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          locality,
          style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
        ),
        16.verticalSpace,
        Consumer<TemperatureProvider>(builder: (context, tempProvider, _) {
          return Text(
            tempProvider.temperatureInCelcius
                ? todayWeatherData.weatherDataList[0].main.tempKelvin
                    .toCelsiusString()
                : todayWeatherData.weatherDataList[0].main.tempKelvin
                    .toFahrenheitString(),
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
          );
        }),
        24.verticalSpace,
        Image.asset(
          AppConstants.weatherImages
              .findImageForWeather(todayWeatherData.mostFrequentWeatherType),
          height: 250.h,
          width: 250.w,
        ),
        20.verticalSpace,
        Consumer<TemperatureProvider>(builder: (context, tempProvider, _) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "H: ${tempProvider.temperatureInCelcius ? todayWeatherData.weatherDataList[0].main.tempMaxKelvin.toCelsiusString() : todayWeatherData.weatherDataList[0].main.tempMaxKelvin.toFahrenheitString()}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              20.horizontalSpace,
              Text(
                "L: ${tempProvider.temperatureInCelcius ? todayWeatherData.weatherDataList[0].main.tempMinKelvin.toCelsiusString() : todayWeatherData.weatherDataList[0].main.tempMinKelvin.toFahrenheitString()}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          );
        }),
        24.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).r,
          child: const Divider(),
        ),
        20.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24).r,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "5 - DAY FORECAST",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
