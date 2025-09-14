import 'package:ayana_space_app/cores/dependenciesInjection/service_locator.dart';
import 'package:ayana_space_app/cores/networks/base_dio.dart';

Future configureDioDependencies() async {
  serviceLocator.registerLazySingleton<DioClient>(
    () => DioClient(),
  );
}
