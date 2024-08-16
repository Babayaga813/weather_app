import 'package:dio/dio.dart';
import 'package:weather_app/BOs/News.dart';
import 'package:weather_app/Helpers/AppConstants/AppConstants.dart';
import 'package:weather_app/Helpers/ServiceResult/ServiceResult.dart';
import 'package:weather_app/Helpers/Utilities/utilities.dart';

class NewsAPI {
  final Dio _dio = Dio();
  Future<ServiceResult<List<News>>> getCategorizedNews(
      String newsCategory) async {
    try {
      List<News> news = [];
      Response response;
      String tempType = AppConstants
          .todayWeatherData.first.weatherDataList.first.main.tempKelvin
          .toTemperatureDescription();
      if (newsCategory != tempType && newsCategory != "*") {
        response = await _dio.get(
          "https://newsapi.org/v2/top-headlines?country=$newsCategory&apiKey=${AppConstants.newsApiKey}",
        );
      } else {
        response = await _dio.get(
          "https://newsapi.org/v2/everything?q=$newsCategory&apiKey=${AppConstants.newsApiKey}",
        );
      }

      if (response.statusCode == 200) {
        var responseData = response.data;

        for (var element in responseData["articles"]) {
          var data = News.fromJson(element);
          news.add(data);
        }
        return ServiceResult(
            statusCode: StatusCode.ok,
            data: news,
            message: "Fetched news successfully");
      } else {
        return ServiceResult(
            statusCode: StatusCode.internalServerError,
            data: [],
            message: "Unknown error from server");
      }
    } catch (e) {
      return ServiceResult(
          statusCode: StatusCode.expectationFailed,
          data: [],
          message: "Exception occured");
    }
  }
}
