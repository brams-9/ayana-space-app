import 'package:ayana_space_app/datas/dto/launches_responses.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'launches_network.g.dart';

@RestApi(baseUrl: "https://api.spacexdata.com/v4")
abstract class LaunchesNetwork {
  factory LaunchesNetwork(Dio dio, {String baseUrl}) = _LaunchesNetwork;

  @GET("/launches/{type}")
  Future<List<LaunchesResponses>> getLaunchesByType(@Path("type") String type);
}
