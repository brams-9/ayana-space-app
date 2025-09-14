import 'package:ayana_space_app/datas/models/launches.dart';
import 'package:flutter/material.dart';
import 'package:ayana_space_app/cores/repositories/launches_list_repository.dart';
import 'package:ayana_space_app/cores/dependenciesInjection/service_locator.dart';

class HomePageViewModel extends ChangeNotifier {
  HomePageViewModel({required LaunchesListRepository repository})
      : _repository = repository;

  final LaunchesListRepository _repository;

  List<Launches>? _upCominglaunches;
  List<Launches>? _pastlaunches;
  List<Launches>? get upCominglaunches => _upCominglaunches;
  List<Launches>? get pastlaunches => _pastlaunches;

  Launches? get latestlaunches => _upCominglaunches?[0];

  bool _isUpComingLoading = false;
  bool get isUpComingLoading => _isUpComingLoading;

  bool _isPastLoading = false;
  bool get isPastLoading => _isPastLoading;

  bool _isLatestLoading = false;
  bool get isLatestLoading => _isLatestLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchLaunches(LaunchType type) async {
    _error = null;
    try {
      switch (type) {
        case LaunchType.upComing:
          _isUpComingLoading = true;
          notifyListeners();
          _upCominglaunches = await _repository.fetchLaunches(type.value).then(
              (value) => value.map((e) => Launches.fromResponses(e)).toList());
          break;
        case LaunchType.past:
          _isPastLoading = true;
          notifyListeners();
          _pastlaunches = await _repository.fetchLaunches(type.value).then(
              (value) => value.map((e) => Launches.fromResponses(e)).toList());

          break;
        case LaunchType.latest:
          _isLatestLoading = true;
          notifyListeners();

          break;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isUpComingLoading = false;
      _isPastLoading = false;
      _isLatestLoading = false;
      notifyListeners();
    }
  }
}
