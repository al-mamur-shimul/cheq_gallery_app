import 'package:cheq_gallery_app/common/logger.dart';
import 'package:cheq_gallery_app/core/di/app_layer_config.dart';
import 'package:data/data.dart' as dl;

class Env {
  Env({
    required this.showLogs,
  }) {
    init();
  }

  static late Env value;
  final bool showLogs;

  Future<void> init() async {
    value = this;
    await _initLogger();
    await _initDataLayer();
    configureAppLayerDependencies();
  }

  Future<void> _initLogger() async {
    if (showLogs) {
      Log.init();
      Log.i('Logger initialized!');
    }
  }

  Future<void> _initDataLayer() async {
    await dl.DataLayerImpl().init(
      dl.Env(
        showLogs: showLogs,
      ),
    );
  }
}
