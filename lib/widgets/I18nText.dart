import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

/// Widget for simple text translation
class I18nText extends StatelessWidget {
  final String _key;
  final Text child;
  final String? fallbackKey;
  final FlutterI18n? instance;
  final Map<String, String>? translationParams;
  static const _default_text = Text("");

  I18nText(this._key, {this.child = _default_text, this.fallbackKey, this.translationParams, this.instance});

  @override
  Widget build(BuildContext context) {
    return Text(
      FlutterI18n.translate(context, _key,
          fallbackKey: fallbackKey, translationParams: translationParams, instance: instance),
      key: child.key,
      style: child.style,
      strutStyle: child.strutStyle,
      textAlign: child.textAlign,
      textDirection: child.textDirection,
      softWrap: child.softWrap,
      overflow: child.overflow,
      textScaleFactor: child.textScaleFactor,
      maxLines: child.maxLines,
      semanticsLabel: child.semanticsLabel,
      textWidthBasis: child.textWidthBasis,
    );
  }
}
