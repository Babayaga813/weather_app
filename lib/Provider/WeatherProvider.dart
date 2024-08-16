import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/BOs/WeatherData.dart';
import 'package:weather_app/Helpers/AppConstants/AppConstants.dart';
import 'package:weather_app/Helpers/ServiceResult/ServiceResult.dart';
import 'package:weather_app/Helpers/Utilities/utilities.dart';
import 'package:weather_app/Services/WeatherAPI/WeatherAPI.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherAPI _weatherService = GetIt.instance<WeatherAPI>();
  List<WeatherData> weatherData = [];
  bool isLoading = false;
  bool temperatureInCelcius = true;

  Future<bool> getCurrentLocationsWeather(String cityName) async {
    try {
      var responseData = await _weatherService.getCurrentWeather(cityName);
      if (responseData.statusCode == StatusCode.ok) {
        weatherData = responseData.data!;
        var seperatedWeatherData = weatherData.separateWeatherDataByDate();
        AppConstants.todayWeatherData =
            DateWeather.fromList(seperatedWeatherData[0]);
        AppConstants.fiveDaysWeatherData =
            DateWeather.fromList(seperatedWeatherData[1]);
        isLoading = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  void changeTemperature(bool value) {
    temperatureInCelcius = !value;
    notifyListeners();
  }
}
