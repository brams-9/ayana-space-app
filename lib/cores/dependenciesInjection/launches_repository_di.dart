import 'package:ayana_space_app/cores/dependenciesInjection/service_locator.dart';
import 'package:ayana_space_app/cores/networks/base_dio.dart';
import 'package:ayana_space_app/cores/repositories/launches_list_repository.dart';

Future configureLaunchesRepositoryDependencies() async {
  serviceLocator.registerLazySingleton<LaunchesListRepository>(
    () => LaunchesListRepositoryImpl(
      serviceLocator<DioClient>().dio,
    ),
  );
}
