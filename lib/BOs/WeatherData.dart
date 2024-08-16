import 'package:intl/intl.dart';
import 'Weather.dart';
import 'WeatherInfo.dart';
import 'Wind.dart';

class WeatherData {
  final int dt;
  final WeatherInfo main;
  final List<Weather> weather;
  final Wind wind;
  final DateTime dtTxt;

  WeatherData({
    required this.dt,
    required this.main,
    required this.weather,
    required this.wind,
    required this.dtTxt,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    // Parse the dtTxt string into DateTime
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(json['dt_txt']);

    return WeatherData(
      dt: json['dt'],
      main: WeatherInfo.fromJson(json['main']),
      weather: List<Weather>.from(
          json['weather'].map((item) => Weather.fromJson(item))),
      wind: Wind.fromJson(json['wind']),
      dtTxt: dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    // Format the DateTime object back to a string
    String dtTxtString = DateFormat("yyyy-MM-dd HH:mm:ss").format(dtTxt);

    return {
      'dt': dt,
      'main': main.toJson(),
      'weather': List<dynamic>.from(weather.map((item) => item.toJson())),
      'wind': wind.toJson(),
      'dt_txt': dtTxtString,
    };
  }
}

class DateWeather {
  final DateTime date;
  final String dayOfWeek;
  final List<WeatherData> weatherDataList;
  final String mostFrequentWeatherType;
  final String mostFrequentWeatherIcon;

  DateWeather({
    required this.date,
    required this.dayOfWeek,
    required this.weatherDataList,
    required this.mostFrequentWeatherType,
    required this.mostFrequentWeatherIcon,
  });

  static List<DateWeather> fromList(List<WeatherData> weatherDataList) {
    // Group weather data by date
    Map<DateTime, List<WeatherData>> groupedData = {};

    for (var data in weatherDataList) {
      // Extract the date part from the DateTime
      DateTime dateOnly =
          DateTime(data.dtTxt.year, data.dtTxt.month, data.dtTxt.day);

      if (groupedData.containsKey(dateOnly)) {
        groupedData[dateOnly]!.add(data);
      } else {
        groupedData[dateOnly] = [data];
      }
    }

    // Convert the map to a list of DateWeather objects
    return groupedData.entries.map((entry) {
      // Determine the most frequent weather type and its icon
      Map<String, int> weatherTypeCount = {};
      Map<String, String> weatherTypeIcon = {};

      for (var weatherData in entry.value) {
        for (var weather in weatherData.weather) {
          if (weatherTypeCount.containsKey(weather.main)) {
            weatherTypeCount[weather.main] =
                (weatherTypeCount[weather.main] ?? 0) + 1;
          } else {
            weatherTypeCount[weather.main] = 1;
            weatherTypeIcon[weather.main] =
                weather.icon; // Store icon for weather type
          }
        }
      }

      // Find the most frequent weather type
      var mostFrequentEntry =
          weatherTypeCount.entries.reduce((a, b) => a.value > b.value ? a : b);

      String mostFrequentWeatherType = mostFrequentEntry.key;
      String mostFrequentWeatherIcon =
          weatherTypeIcon[mostFrequentWeatherType] ?? '';

      String dayOfWeek = DateFormat('EEE').format(entry.key);
      return DateWeather(
        date: entry.key,
        dayOfWeek: dayOfWeek,
        weatherDataList: entry.value,
        mostFrequentWeatherType: mostFrequentWeatherType,
        mostFrequentWeatherIcon: mostFrequentWeatherIcon,
      );
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'date': DateFormat("yyyy-MM-dd").format(date),
      'dayOfWeek': dayOfWeek,
      'weatherDataList': List<dynamic>.from(
          weatherDataList.map((weather) => weather.toJson())),
      'mostFrequentWeatherType': mostFrequentWeatherType,
      'mostFrequentWeatherIcon': mostFrequentWeatherIcon,
    };
  }

  @override
  String toString() {
    return 'Date: ${DateFormat("yyyy-MM-dd").format(date)}, Day: $dayOfWeek, Weather Data: ${weatherDataList.map((w) => w.toJson()).toList()}, Most Frequent Weather Type: $mostFrequentWeatherType, Icon: $mostFrequentWeatherIcon';
  }
}
