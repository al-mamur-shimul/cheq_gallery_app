import 'package:cheq_gallery_app/app/app.dart';
import 'package:cheq_gallery_app/bootstrap.dart';
import 'package:cheq_gallery_app/config/env_staging.dart';

void main() {
  final staging = Staging(
    showLogs: true,
  );
  bootstrap(() => const App(), staging);
}
