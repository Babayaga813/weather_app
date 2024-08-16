class WeatherInfo {
  final double tempKelvin; // Keep temperature in Kelvin as a double
  final double tempMinKelvin; // Minimum temperature in Kelvin as a double
  final double tempMaxKelvin; // Maximum temperature in Kelvin as a double
  final int pressure;
  final int humidity;

  WeatherInfo({
    required this.tempKelvin,
    required this.tempMinKelvin,
    required this.tempMaxKelvin,
    required this.pressure,
    required this.humidity,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      tempKelvin: json['temp'].toDouble(),
      tempMinKelvin: json['temp_min'].toDouble(),
      tempMaxKelvin: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': tempKelvin,
      'temp_min': tempMinKelvin,
      'temp_max': tempMaxKelvin,
      'pressure': pressure,
      'humidity': humidity,
    };
  }
}
