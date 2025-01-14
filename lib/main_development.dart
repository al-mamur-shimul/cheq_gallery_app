import 'package:cheq_gallery_app/app/app.dart';
import 'package:cheq_gallery_app/bootstrap.dart';
import 'package:cheq_gallery_app/config/env_development.dart';

void main() {
  final development = Development(
    showLogs: true,
  );
  bootstrap(() => const App(), development );
}
