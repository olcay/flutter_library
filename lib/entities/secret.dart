class Secret {
  final String sentryDsn;

  Secret({this.sentryDsn = ""});

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(sentryDsn: jsonMap["sentry_dsn"]);
  }
}