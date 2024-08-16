import 'package:flutter/widgets.dart';

class TemperatureProvider extends ChangeNotifier {
  bool temperatureInCelcius = true;
  void changeTemperature(bool value) {
    temperatureInCelcius = !value;
    notifyListeners();
  }
}
