import 'package:dio/dio.dart';
import 'package:weather_app/BOs/WeatherData.dart';
import 'package:weather_app/Helpers/AppConstants/AppConstants.dart';
import 'package:weather_app/Helpers/ServiceResult/ServiceResult.dart';

class WeatherAPI {
  final Dio _dio = Dio();
  Future<ServiceResult<List<WeatherData>>> getCurrentWeather(
      String cityName) async {
    try {
      List<WeatherData> weatherData = [];
      var response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&exclude=minutely,current&APPID=${AppConstants.weatherApiKey}',
      );
      var responseData = response.data["list"];
      for (var element in responseData) {
        var data = WeatherData.fromJson(element);
        weatherData.add(data);
      }
      return ServiceResult(
          statusCode: StatusCode.ok,
          data: weatherData,
          message: "Fetched data");
    } catch (e) {
      return ServiceResult(
          statusCode: StatusCode.ok,
          data: [],
          message: "Exception occured while fetching");
    }
  }
}
