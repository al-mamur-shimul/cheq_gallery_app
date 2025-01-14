import 'package:data/core/data_layer_generator.dart';
import 'package:get_it/get_it.dart';

import 'config/env.dart';
import 'core/logger.dart';
import 'data_layer.dart';

GetIt getIt = GetIt.instance;

class DataLayerImpl implements DataLayer {
  static late DataLayer instance;

  @override
  void dispose() {
    getIt.reset();
    instance.dispose();
  }

  @override
  Future<void> init(Env env) async {
    instance = this;
    getIt.registerSingleton<Env>(env);
    await _initLogger(env);
    configureDataLayerDependencies();
  }

  Future<void> _initLogger(Env env) async {
    if (env.showLogs) {
      Log.init();
    }
  }

  @override
  T createRepository<T extends Object>() {
    return getIt.get<T>();
  }
}
