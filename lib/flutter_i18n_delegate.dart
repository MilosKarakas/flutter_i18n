import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/loaders/translation_loader.dart';
import 'package:flutter_i18n/utils/message_printer.dart';

import 'flutter_i18n.dart';

/// Translation delegate that manage the new locale received from the framework
class FlutterI18nDelegate extends LocalizationsDelegate<FlutterI18n> {
  static FlutterI18n? _translationObject;
  Locale? currentLocale;

  FlutterI18nDelegate(
      {translationLoader,
      MissingTranslationHandler? missingTranslationHandler,
      String keySeparator = "."}) {
    _translationObject = FlutterI18n(
      translationLoader,
      keySeparator,
      missingTranslationHandler: missingTranslationHandler,
    );
  }

  @override
  bool isSupported(final Locale locale) {
    return true;
  }

  @override
  Future<FlutterI18n> load(final Locale locale) async {
    MessagePrinter.info("New locale: $locale");
    final TranslationLoader translationLoader =
        _translationObject!.translationLoader!;

    bool localesEqual = false;
    if (translationLoader.locale != null) {
      String currentLocaleString = '';
      if (translationLoader.locale?.languageCode != null) {
        currentLocaleString += translationLoader.locale!.languageCode;
      }
      if (translationLoader.locale?.scriptCode != null) {
        currentLocaleString += '_${translationLoader.locale!.scriptCode}';
      }
      if (translationLoader.locale?.countryCode != null) {
        currentLocaleString += '_${translationLoader.locale!.countryCode}';
      }

      String newLocaleString = '';
      if (locale.languageCode != null) {
        newLocaleString += locale.languageCode;
      }
      if (locale.scriptCode != null) {
        newLocaleString += '_${locale.scriptCode}';
      }
      if (locale.countryCode != null) {
        newLocaleString += '_${locale.countryCode}';
      }
      localesEqual = currentLocaleString == newLocaleString;
    }

    if (!localesEqual ||
        _translationObject!.decodedMap == null ||
        _translationObject!.decodedMap!.isEmpty) {
      translationLoader.locale = currentLocale = locale;
      await _translationObject!.load();
    }
    return _translationObject!;
  }

  @override
  bool shouldReload(final FlutterI18nDelegate old) {
    return this.currentLocale == null ||
        this.currentLocale == old.currentLocale;
  }
}
