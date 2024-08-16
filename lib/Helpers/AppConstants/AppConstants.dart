import 'package:geocoding/geocoding.dart';
import '../../BOs/News.dart';
import '../../BOs/WeatherData.dart';

class AppConstants {
  static const String weatherApiKey = "3c47b667d737be6396a3f655b3f08618";
  static const String newsApiKey = "bf6626eb1db54e7db971ed32d3073230";
  static List<DateWeather> todayWeatherData = [];
  static List<DateWeather> fiveDaysWeatherData = [];
  static List<News> news = [];
  static Placemark? currentLocationDetails;
  static const List<String> weatherImages = [
    "assets/images/Clear.png",
    "assets/images/Clouds.png",
    "assets/images/Rain.png",
    "assets/images/Drizzle.png",
    "assets/images/Thunderstorm.png",
    "assets/images/Snow.png",
    "assets/images/Atmosphere.png",
  ];
}
