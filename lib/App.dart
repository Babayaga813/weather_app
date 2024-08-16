import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Helpers/Navigation/AppRoutes.dart';
import 'package:weather_app/Provider/LocationProvider.dart';
import 'package:weather_app/Provider/NewsProvider.dart';
import 'package:weather_app/Provider/TemperatureProvider.dart';
import 'package:weather_app/Provider/WeatherProvider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(448, 973),
        builder: (context, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => LocationProvider()),
                ChangeNotifierProvider(create: (_) => WeatherProvider()),
                ChangeNotifierProvider(create: (_) => NewsProvider()),
                ChangeNotifierProvider(create: (_) => TemperatureProvider())
              ],
              child: MaterialApp.router(
                title: 'Weather & News',
                routerConfig: AppRoutes().routes,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    useMaterial3: true,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    brightness: Brightness.light,
                    appBarTheme:
                        const AppBarTheme(backgroundColor: Color(0xFFEDF8FF)),
                    scaffoldBackgroundColor: const Color(0xFFEDF8FF),
                    colorSchemeSeed: const Color(0xffF8F8F8)),
              ));
        });
  }
}
