import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> replaceTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static void goBack() {
    return navigatorKey.currentState!.pop();
  }

  static Future<dynamic> navigateToWithFadeTransition(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          final Widget page = navigatorKey.currentState!.widget.onGenerateRoute!(
            RouteSettings(name: routeName, arguments: arguments),
          ).buildPage(context, animation, secondaryAnimation);

          return FadeTransition(
            opacity: animation,
            child: page,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}