import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/Helpers/Navigation/AppRouteConstants.dart';
import 'package:weather_app/Pages/ErrorPage.dart';
import 'package:weather_app/Pages/NewsPage.dart';
import 'package:weather_app/Pages/SettingsPage.dart';
import 'package:weather_app/Pages/SplashScreen.dart';

class AppRoutes {
  GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        name: AppRouteConstants.splashRoute,
        path: "/",
        pageBuilder: (context, state) =>
            const CupertinoPage(child: SplashScreen()),
      ),
      GoRoute(
        name: AppRouteConstants.errorRoute,
        path: "/error",
        pageBuilder: (context, state) =>
            const CupertinoPage(child: ErrorPage()),
      ),
      GoRoute(
        name: AppRouteConstants.newsRoute,
        path: "/news",
        pageBuilder: (context, state) => const CupertinoPage(child: NewsPage()),
      ),
      GoRoute(
        name: AppRouteConstants.settingsRoute,
        path: "/settings",
        pageBuilder: (context, state) =>
            const CupertinoPage(child: SettingsPage()),
      ),
    ],
  );
}
