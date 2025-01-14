import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cheq_gallery_app/common/logger.dart';
import 'package:cheq_gallery_app/config/env.dart';
import 'package:flutter/widgets.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder, Env env) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Log.i('Environment initialized!');

  if (Env.value.showLogs) {
    Bloc.observer = const AppBlocObserver();
  }

  // Add cross-flavor configuration here

  runApp(await builder());
}
