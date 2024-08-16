import 'package:flutter/material.dart';
import 'package:weather_app/BOs/WeatherData.dart';
import 'package:weather_app/Helpers/AppConstants/AppConstants.dart';
import 'package:weather_app/Helpers/Utilities/utilities.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FiveDaysWeatherDetails extends StatelessWidget {
  final List<DateWeather> weatherDataList;

  const FiveDaysWeatherDetails({
    super.key,
    required this.weatherDataList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: double.maxFinite,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataList.length,
        itemBuilder: (context, index) {
          final weatherDay = weatherDataList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  weatherDay.dayOfWeek,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                12.verticalSpace,
                Image.asset(
                  AppConstants.weatherImages.findImageForWeather(
                    weatherDay.mostFrequentWeatherType,
                  ),
                  height: 70.h,
                  width: 70.w,
                ),
                8.verticalSpace,
                Text(
                  weatherDay.weatherDataList[0].main.tempKelvin
                      .toCelsiusString(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
