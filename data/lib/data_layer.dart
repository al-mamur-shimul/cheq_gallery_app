import 'config/env.dart';

abstract class DataLayer {
  const DataLayer();

  void init(Env env);

  T createRepository<T extends Object>();

  void dispose();
}
