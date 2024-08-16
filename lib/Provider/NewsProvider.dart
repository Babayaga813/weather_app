import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/Helpers/AppConstants/AppConstants.dart';
import 'package:weather_app/Helpers/Utilities/utilities.dart';
import 'package:weather_app/Services/NewsAPI/NewsAPI.dart';
import '../Helpers/ServiceResult/ServiceResult.dart';

class NewsProvider extends ChangeNotifier {
  final NewsAPI _newsService = GetIt.instance<NewsAPI>();
  bool isLoading = false;
  bool newsFetched = false;
  String newsType = AppConstants
      .todayWeatherData[0].weatherDataList[0].main.tempKelvin
      .toTemperatureDescription();

  Future<bool> getNewsBasedOnWeather() async {
    try {
      isLoading = true;
      newsFetched = false;
      changeNewsType(newsType);
      var responseData = await _newsService.getCategorizedNews(newsType);
      if (responseData.statusCode == StatusCode.ok) {
        AppConstants.news = responseData.data!;
        isLoading = false;
        newsFetched = true;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  void changeNewsType(String newsCategory) {
    newsType = newsCategory;
    notifyListeners();
  }
}
