class Env {
  Env({
    required this.showLogs,
  }) {
    value = this;
  }

  static late Env value;
  final bool showLogs;
}
