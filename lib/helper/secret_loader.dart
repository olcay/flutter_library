import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;
import 'package:kutuphane/entities/secret.dart';

class SecretLoader {
  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>("assets/secrets.json",
        (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
