import 'package:googleapis/bigquery/v2.dart';

class Secret {
  final String sentryDsn;
  final Map serviceAccountCredentials;

  Secret({this.sentryDsn = "", this.serviceAccountCredentials});

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(sentryDsn: jsonMap["sentry_dsn"], serviceAccountCredentials: jsonMap["service_account_credentials"]);
  }
}