import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

extension StringExtension on String {

  /// MD5加密
  /// [content] 加密内容
  String md5String() {
    Uint8List uint8list = const Utf8Encoder().convert(this);
    Digest digest = md5.convert(uint8list);
    return digest.toString();
  }
}