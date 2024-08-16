import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/App.dart';
import 'package:weather_app/Services/GeoLocation/GeoLocation.dart';
import 'package:weather_app/Services/NewsAPI/NewsAPI.dart';
import 'package:weather_app/Services/URLLauncher/URLLauncher.dart';
import 'package:weather_app/Services/WeatherAPI/WeatherAPI.dart';

void main() {
  runApp(const App());
  registerServices();
}

void registerServices() {
  GetIt.instance.registerSingleton<GeoLocation>(GeoLocation());
  GetIt.instance.registerSingleton<WeatherAPI>(WeatherAPI());
  GetIt.instance.registerSingleton<NewsAPI>(NewsAPI());
  GetIt.instance.registerSingleton<URLLauncher>(URLLauncher());
}
