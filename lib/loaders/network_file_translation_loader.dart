import 'dart:async';

import 'package:http/http.dart' as http;

import 'file_translation_loader.dart';

/// Loads translations from the remote resource
class NetworkFileTranslationLoader extends FileTranslationLoader {
  final Uri baseUri;
  final void Function(int, dynamic)? onError;

  NetworkFileTranslationLoader(
      {required this.baseUri,
        forcedLocale,
        fallbackFile = "en",
        useCountryCode = false,
        useScriptCode = false,
        decodeStrategies,
        this.onError
      })
      : super(
      fallbackFile: fallbackFile,
      useCountryCode: useCountryCode,
      forcedLocale: forcedLocale,
      decodeStrategies: decodeStrategies);

  /// Load the file using an http client
  @override
  Future<String> loadString(final String fileName, final String extension) async {
    final resolvedUri = resolveUri(fileName, extension);
    try {
      final result = await http.get(resolvedUri);
      return result.body;
    } catch (exception) {
      if (exception is ArgumentError && exception.toString().contains('Invalid status code 0')) {
        onError?.call(0, '');
        rethrow;
      }
      rethrow;
    }
  }

  Uri resolveUri(final String fileName, final String extension) {
    return baseUri.resolve('$fileName.$extension');
  }
}
