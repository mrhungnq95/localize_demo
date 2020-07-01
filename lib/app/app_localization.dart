import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppLocalization {
  final Locale _locale;

  Map<String, Map<String, String>> _localizeData;

  static const List<Locale> supportedLocales = [
    Locale('vi', 'VN'),
    Locale('en', 'US'),
    Locale('de', 'DE')
  ];

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegates();

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  AppLocalization(this._locale, this._localizeData);

  String localize(String pText, {String pCountryCode, List<String> pParams}) {
    String _countryCode = pCountryCode ?? _locale.countryCode;
    String value;

    if (_countryCode == null ||
        _countryCode.isEmpty ||
        !_localizeData.keys.contains(_countryCode)) {
      _countryCode = _localizeData.keys.toList()[0];
    }

    value = _localizeData[_countryCode][pText];

    if (pParams != null && pParams.isNotEmpty) {
      for (int i = 0, length = pParams.length; i < length; i++) {
        value = value?.replaceAll('%$i%', '${pParams[i]}');
      }
    }
    return value;
  }
}

class _AppLocalizationDelegates extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegates();

  @override
  bool isSupported(Locale locale) {
    return AppLocalization.supportedLocales
            .where((element) => element.languageCode == locale.languageCode) !=
        null;
  }

  Future<Map<String, Map<String, String>>> loadLangByCode(
      String languageCode) async {
    String contentJson = await rootBundle.loadString("lang/$languageCode.json");

    Map<String, dynamic> contentMapJson = jsonDecode(contentJson);
    var localizeData = contentMapJson
        .map((key, value) => MapEntry(key, Map<String, String>.from(value)));

    return localizeData;
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    var localize = await loadLangByCode(locale.languageCode);
    AppLocalization appLocalization = AppLocalization(locale, localize);
    return appLocalization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
