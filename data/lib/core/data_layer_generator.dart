import 'package:data/core/data_layer_generator.config.dart';
import 'package:injectable/injectable.dart';

import '../data_layer_impl.dart';

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDataLayerDependencies() => getIt.init();
