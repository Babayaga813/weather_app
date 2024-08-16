import 'package:intl/intl.dart';
import '../../BOs/WeatherData.dart';
import '../AppConstants/AppConstants.dart';

extension TemperatureDescription on double {
  String toTemperatureDescription() {
    if (this < 273.15) {
      return "cold"; // Below 0°C
    } else if (this >= 273.15 && this < 293.15) {
      return "cool"; // 0°C to 20°C
    } else if (this >= 293.15 && this < 303.15) {
      return "normal"; // 20°C to 30°C
    } else {
      return "hot"; // Above 30°C
    }
  }
}

extension FilterWeather on List<WeatherData> {
  List<List<WeatherData>> separateWeatherDataByDate() {
    // Get the current date at midnight to compare with `dtTxt`
    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);

    // Create two lists: one for today's data and one for other dates
    List<WeatherData> todayData = [];
    List<WeatherData> otherData = [];

    // Separate the data based on the date
    for (var data in this) {
      if (data.dtTxt.isAtSameMomentAs(startOfToday) ||
          (data.dtTxt.isAfter(startOfToday) &&
              data.dtTxt.isBefore(startOfToday.add(const Duration(days: 1))))) {
        todayData.add(data);
      } else {
        otherData.add(data);
      }
    }

    return [todayData, otherData];
  }
}

extension TemperatureConversion on double {
  String toCelsiusString() {
    final celsius = this - 273.15;
    final formattedCelsius = NumberFormat("0").format(celsius);
    return "$formattedCelsius°C";
  }

  String toFahrenheitString() {
    final fahrenheit = (this - 273.15) * 9 / 5 + 32;
    final formattedFahrenheit = NumberFormat("0").format(fahrenheit);
    return "$formattedFahrenheit°F";
  }
}

String categorizeTemperature(double kelvin) {
  // Define temperature thresholds for each category
  const double coolThreshold = 283.15; // 10°C
  const double coldThreshold = 273.15; // 0°C
  const double hotThreshold = 303.15; // 30°C

  // Determine the category based on temperature
  if (kelvin >= hotThreshold) {
    return 'hot'; // Hot weather
  } else if (kelvin >= coolThreshold) {
    return 'cool'; // Cool weather
  } else if (kelvin >= coldThreshold) {
    return 'cold'; // Cold weather
  } else {
    return 'normal'; // Normal temperature (below cold threshold)
  }
}

extension WeatherImageFinder on List<String> {
  // Method to find and return the image path for a given weather description
  String findImageForWeather(String weatherDescription) {
    print(weatherDescription);

    // Define the list of weather types and corresponding images
    final List<String> weatherTypes = [
      'Clear',
      'Clouds',
      'Rain',
      'Drizzle',
      'Thunderstorm',
      'Snow',
      'Atmosphere',
    ];

    const List<String> weatherImages = AppConstants.weatherImages;

    // Normalize the input weatherDescription to lower case
    final lowerCaseWeatherDescription = weatherDescription.toLowerCase();

    // Iterate through weather types and find a match
    for (int i = 0; i < weatherTypes.length; i++) {
      if (lowerCaseWeatherDescription.contains(weatherTypes[i].toLowerCase())) {
        return weatherImages[i];
      }
    }
    // Return a default image if no match is found
    return "assets/images/Clear.png";
  }
}
