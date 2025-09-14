import 'package:ayana_space_app/cores/networks/launches_network.dart';
import 'package:ayana_space_app/datas/dto/launches_responses.dart';
import 'package:dio/dio.dart';

abstract class LaunchesListRepository {
  Future<List<LaunchesResponses>> fetchLaunches(String type);
}

class LaunchesListRepositoryImpl implements LaunchesListRepository {
  final LaunchesNetwork _network;

  LaunchesListRepositoryImpl(Dio dio) : _network = LaunchesNetwork(dio);

  @override
  Future<List<LaunchesResponses>> fetchLaunches(String type) {
    return _network.getLaunchesByType(type);
  }
}
