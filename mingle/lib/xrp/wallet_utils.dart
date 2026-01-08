
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

Uint8List hexToBytes(String hex) {
  final clean = hex.trim();
  if (clean.length % 2 != 0) {
    throw FormatException("Invalid hex length");
  }

  return Uint8List.fromList(
    List.generate(
      clean.length ~/ 2,
      (i) => int.parse(clean.substring(i * 2, i * 2 + 2), radix: 16),
    ),
  );
}


Future<Uint8List> getPrivateKeyBytes(String name) async {
  final String hex = await rootBundle.loadString(
    'assets/keys/$name.txt',
  );

  return hexToBytes(hex);
}
