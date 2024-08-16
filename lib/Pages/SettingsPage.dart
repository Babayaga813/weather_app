import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Helpers/AppConstants/AppConstants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/Helpers/Utilities/utilities.dart';
import 'package:weather_app/Provider/NewsProvider.dart';
import 'package:weather_app/Provider/TemperatureProvider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Preferences",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => GoRouter.of(context).pop(),
            icon: const Icon(Icons.chevron_left)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.verticalSpace,
            Row(
              children: [
                Icon(
                  Icons.place,
                  size: 24.sp,
                ),
                12.horizontalSpace,
                Text(
                  AppConstants.currentLocationDetails!.locality!,
                  style:
                      TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            20.verticalSpace,
            Text(
              "Temperature Settings",
              style: TextStyle(fontSize: 20.sp),
            ),
            6.verticalSpace,
            Consumer<TemperatureProvider>(builder: (context, tempProvider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: Colors.blueAccent.shade100,
                          value: true,
                          groupValue: tempProvider.temperatureInCelcius,
                          onChanged: (value) {
                            tempProvider.changeTemperature(!value!);
                          }),
                      6.horizontalSpace,
                      Text(
                        "°C",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      Radio(
                          activeColor: Colors.blueAccent.shade100,
                          value: false,
                          groupValue: tempProvider.temperatureInCelcius,
                          onChanged: (value) {
                            tempProvider.changeTemperature(!value!);
                          }),
                      6.horizontalSpace,
                      Text("°F", style: TextStyle(fontSize: 16.sp)),
                    ],
                  ),
                ],
              );
            }),
            30.verticalSpace,
            Text(
              "News Settings",
              style: TextStyle(fontSize: 20.sp),
            ),
            6.verticalSpace,
            Consumer<NewsProvider>(builder: (context, newsProvider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: Colors.blueAccent.shade100,
                          value: "*",
                          groupValue: newsProvider.newsType,
                          onChanged: (value) {
                            newsProvider.changeNewsType(value!);
                          }),
                      6.horizontalSpace,
                      Text("Everything", style: TextStyle(fontSize: 16.sp)),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          activeColor: Colors.blueAccent.shade100,
                          value: AppConstants.todayWeatherData.first
                              .weatherDataList.first.main.tempKelvin
                              .toTemperatureDescription(),
                          groupValue: newsProvider.newsType,
                          onChanged: (value) {
                            newsProvider.changeNewsType(value!);
                          }),
                      6.horizontalSpace,
                      Text(
                        "Based On Weather",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      Radio(
                          activeColor: Colors.blueAccent.shade100,
                          value: AppConstants
                              .currentLocationDetails!.isoCountryCode!
                              .toLowerCase(),
                          groupValue: newsProvider.newsType,
                          onChanged: (value) {
                            newsProvider.changeNewsType(value!);
                          }),
                      6.horizontalSpace,
                      Text("Country Top-Headlines",
                          style: TextStyle(fontSize: 16.sp)),
                    ],
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
