import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en'); // Default locale is English

  Locale get locale => _locale;

  void changeLanguage(String languageCode) {
    if (['en', 'es', 'fr', 'rw'].contains(languageCode)) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }
}
