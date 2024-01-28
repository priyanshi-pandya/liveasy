import 'package:flutter/material.dart';
import 'package:liveasy_assignment/screens/language_page.dart';
import 'package:liveasy_assignment/screens/number_page.dart';
import 'package:liveasy_assignment/screens/profile_selection_page.dart';
import 'package:liveasy_assignment/screens/verification_page.dart';

class RouteGenerator {
  static const String languagePage = '/languagePage';
  static const String numberPage = '/numberPage';
  static const String verificationPage = '/verificationPage';
  static const String profileSelectionPage = '/profileSelectionPage';
  static const String defaultPage = '/';

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case defaultPage:
        return MaterialPageRoute(builder: (_) => LanguagePage());
      case numberPage:
        return MaterialPageRoute(builder: (_) => NumberPage());
      case verificationPage:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => VerificationPage(
            number: args['number'],
            verificationId: args['verifyId'],
          ),
        );
      case profileSelectionPage:
        return MaterialPageRoute(builder: (_) => ProfileSelectionPage());
      default:
        return MaterialPageRoute(builder: (_) => LanguagePage());
    }
  }
}
