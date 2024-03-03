import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart';

class CryptService {
  String secretKey = "Xero";

String encryptString(String plainText,  ) {
  final keyBytes = utf8.encode(secretKey);
  final key = KeyParameter(keyBytes);

  final params = ParametersWithIV(key, Uint8List.fromList(utf8.encode(secretKey)));
  final cipher = BlockCipher("AES/CTR")..init(true, params);

  final plainTextBytes = utf8.encode(plainText);
  final encryptedBytes = cipher.process(Uint8List.fromList(plainTextBytes));

  return base64.encode(encryptedBytes);
}

String decryptString(String encryptedText,  ) {
  final keyBytes = utf8.encode(secretKey);
  final key = KeyParameter(keyBytes);

  final params = ParametersWithIV(key, Uint8List.fromList(utf8.encode(secretKey)));
  final cipher = BlockCipher("AES/CTR")..init(false, params);

  final encryptedBytes = base64.decode(encryptedText);
  final decryptedBytes = cipher.process(Uint8List.fromList(encryptedBytes));

  return utf8.decode(decryptedBytes);
}

}
