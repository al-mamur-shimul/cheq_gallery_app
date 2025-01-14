import 'package:cheq_gallery_app/app/app.dart';
import 'package:cheq_gallery_app/bootstrap.dart';
import 'package:cheq_gallery_app/config/env_production.dart';

void main() {
  final production = Production(
    showLogs: false,
  );
  bootstrap(() => const App(), production);
}
